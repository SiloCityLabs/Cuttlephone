#!/bin/bash
#
# Sync a directory of .3mf files onto an existing Thingiverse thing.
# Match on filename only. Replace same names, add new names,
# and delete remote files that are not in the local set.
# After a successful file sync, append GitHub release notes
# to the existing description (do not replace the hand-written body).
#
# Env:
#   THINGIVERSE_TOKEN  OAuth access token (required)
#   THING_ID           Thingiverse thing id (default 4809828)
#   RELEASE_TAG        GitHub release tag, used in the notes heading
#   TV_SLEEP           Seconds between API calls (default 1)
#   TV_RETRIES         Attempts on HTTP 429/5xx (default 5)
#
# Usage:
#   ./scripts/upload_thingiverse.sh [--dry-run] <3mf-dir> [notes.md]

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
# local secrets; does not override vars already in the environment
if [ -z "${THINGIVERSE_TOKEN:-}" ] && [ -f "$ROOT_DIR/.env" ]; then
    set -a
    # strip CR so a Windows .env works in Git Bash
    # shellcheck disable=SC1091
    . <(tr -d '\r' < "$ROOT_DIR/.env")
    set +a
fi

TV_API="https://api.thingiverse.com"
TV_UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
THING_ID="${THING_ID:-4809828}"
TV_SLEEP="${TV_SLEEP:-1}"
TV_RETRIES="${TV_RETRIES:-5}"
DRY_RUN=0

usage() {
    echo "Usage: $0 [--dry-run] <3mf-dir> [notes.md]" >&2
    echo "Requires THINGIVERSE_TOKEN. Optional: THING_ID, RELEASE_TAG." >&2
    exit 1
}

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    usage
fi
if [ "${1:-}" = "--dry-run" ]; then
    DRY_RUN=1
    shift
fi

LOCAL_DIR="${1:-}"
NOTES_FILE="${2:-}"
if [ -z "$LOCAL_DIR" ] || [ ! -d "$LOCAL_DIR" ]; then
    usage
fi

if [ -z "${THINGIVERSE_TOKEN:-}" ]; then
    echo "Error: THINGIVERSE_TOKEN is not set" >&2
    exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required" >&2
    exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is required" >&2
    exit 1
fi

TV_WORKDIR=$(mktemp -d)
trap 'rm -rf "$TV_WORKDIR"' EXIT
TV_BODY="$TV_WORKDIR/body.json"
REMOTE_JSON="$TV_WORKDIR/remote.json"

tv_sleep() {
    sleep "$TV_SLEEP"
}

# Write response body to $TV_BODY
tv_api() {
    local method="$1"
    local path="$2"
    shift 2
    local attempt=1
    local code
    while [ "$attempt" -le "$TV_RETRIES" ]; do
        code=$(curl -sS -o "$TV_BODY" -w "%{http_code}" \
            -X "$method" \
            -A "$TV_UA" \
            -H "Authorization: Bearer ${THINGIVERSE_TOKEN}" \
            -H "Accept: application/json" \
            "$@" \
            "${TV_API}${path}") || code="000"
        if [ "$code" -ge 200 ] && [ "$code" -lt 300 ]; then
            tv_sleep
            return 0
        fi
        # Retry 429/5xx. Fail on other errors.
        if [ "$code" = "429" ] || [ "$code" -ge 500 ] || [ "$code" = "000" ]; then
            echo "HTTP ${code} on ${method} ${path} (attempt ${attempt}/${TV_RETRIES})" >&2
            sleep $((attempt * 2))
            attempt=$((attempt + 1))
            continue
        fi
        echo "HTTP ${code} on ${method} ${path}" >&2
        head -c 800 "$TV_BODY" >&2 || true
        echo >&2
        return 1
    done
    echo "Gave up on ${method} ${path} after ${TV_RETRIES} attempts" >&2
    return 1
}

# GET /files may be a raw array or {files: [...]}. Keep {id, name} only.
normalize_remote_files() {
    jq -c '
        (if type == "array" then . else (.files // []) end)
        | map({
            id: (.id | tostring),
            name: (.name // .filename // empty)
          })
        | map(select(.name != "" and .id != "" and .id != "null"))
    ' "$TV_BODY" > "$REMOTE_JSON"
}

fetch_remote_files() {
    echo "Listing files on thing ${THING_ID}"
    tv_api GET "/things/${THING_ID}/files"
    normalize_remote_files
    echo "Remote files: $(jq 'length' "$REMOTE_JSON")"
    jq -r '.[] | "  \(.id)  \(.name)"' "$REMOTE_JSON"
}

remote_id_for_name() {
    local name="$1"
    jq -r --arg n "$name" '[.[] | select(.name == $n) | .id] | first // empty' "$REMOTE_JSON"
}

delete_remote_file() {
    local file_id="$1"
    local name="$2"
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "dry-run: would DELETE file ${file_id} (${name})"
        return 0
    fi
    echo "DELETE file ${file_id} (${name})"
    tv_api DELETE "/things/${THING_ID}/files/${file_id}"
}

# POST fields then the file. Do not send the Bearer token to S3.
s3_upload() {
    local prepare_json="$1"
    local filepath="$2"
    local basename="$3"
    local action
    action=$(jq -r '.action // .upload.action // empty' "$prepare_json")
    if [ -z "$action" ] || [ "$action" = "null" ]; then
        echo "Prepare response missing S3 action URL" >&2
        head -c 800 "$prepare_json" >&2 || true
        echo >&2
        return 1
    fi

    # S3 wants the signed prepare fields first
    local -a forms=()
    local key val
    while IFS= read -r key; do
        [ -z "$key" ] && continue
        [ "$key" = "file" ] && continue # skip file, attached later
        val=$(jq -r --arg k "$key" '(.fields // .upload.fields // {})[$k] // empty' "$prepare_json")
        forms+=(--form-string "${key}=${val}")
    done < <(jq -r '(.fields // .upload.fields // {}) | keys[]' "$prepare_json")

    # POST files
    local attempt=1
    local code
    local s3_body="$TV_WORKDIR/s3-body.txt"
    while [ "$attempt" -le "$TV_RETRIES" ]; do
        code=$(curl -sS -o "$s3_body" -w "%{http_code}" \
            -A "$TV_UA" \
            "${forms[@]}" \
            -F "file=@${filepath};filename=${basename}" \
            "$action") || code="000"
        if [ "$code" -ge 200 ] && [ "$code" -lt 300 ]; then
            tv_sleep
            return 0
        fi
        # retry
        if [ "$code" = "429" ] || [ "$code" -ge 500 ] || [ "$code" = "000" ]; then
            echo "S3 HTTP ${code} for ${basename} (attempt ${attempt}/${TV_RETRIES})" >&2
            sleep $((attempt * 2))
            attempt=$((attempt + 1))
            continue
        fi
        echo "S3 HTTP ${code} for ${basename}" >&2
        head -c 800 "$s3_body" >&2 || true
        echo >&2
        return 1
    done
    echo "Gave up on S3 upload of ${basename} after ${TV_RETRIES} attempts" >&2
    return 1
}

finalize_upload() {
    local prepare_json="$1"
    local redirect file_id
    redirect=$(jq -r '.fields.success_action_redirect // .upload.fields.success_action_redirect // empty' "$prepare_json")
    file_id=$(jq -r '.id // empty' "$prepare_json")

    if [ -n "$redirect" ] && [ "$redirect" != "null" ]; then
        # success_action_redirect is usually https://api.thingiverse.com/files/{id}/finalize
        local -a fin_forms=()
        local key val
        while IFS= read -r key; do
            [ -z "$key" ] && continue
            [ "$key" = "file" ] && continue
            val=$(jq -r --arg k "$key" '(.fields // .upload.fields // {})[$k] // empty' "$prepare_json")
            fin_forms+=(--form-string "${key}=${val}")
        done < <(jq -r '(.fields // .upload.fields // {}) | keys[]' "$prepare_json")
        local attempt=1
        local code
        while [ "$attempt" -le "$TV_RETRIES" ]; do
            code=$(curl -sS -o "$TV_BODY" -w "%{http_code}" \
                -X POST \
                -A "$TV_UA" \
                -H "Authorization: Bearer ${THINGIVERSE_TOKEN}" \
                -H "Accept: application/json" \
                "${fin_forms[@]}" \
                "$redirect") || code="000"
            if [ "$code" -ge 200 ] && [ "$code" -lt 300 ]; then
                tv_sleep
                return 0
            fi
            # retry
            if [ "$code" = "429" ] || [ "$code" -ge 500 ] || [ "$code" = "000" ]; then
                echo "HTTP ${code} on finalize redirect (attempt ${attempt}/${TV_RETRIES})" >&2
                sleep $((attempt * 2))
                attempt=$((attempt + 1))
                continue
            fi
            echo "HTTP ${code} on finalize redirect" >&2
            head -c 800 "$TV_BODY" >&2 || true
            echo >&2
            break
        done
        echo "Redirect finalize failed, trying /files/{id}/finalize" >&2
    fi

    if [ -n "$file_id" ] && [ "$file_id" != "null" ]; then
        tv_api POST "/files/${file_id}/finalize"
        return 0
    fi

    local filename
    filename=$(jq -r '.name // .filename // empty' "$prepare_json")
    jq -n --arg filename "$filename" '{filename: $filename}' > "$TV_WORKDIR/finalize.json"
    tv_api POST "/things/${THING_ID}/finalize" \
        -H "Content-Type: application/json" \
        --data @"$TV_WORKDIR/finalize.json"
}

upload_file() {
    local filepath="$1"
    local basename
    basename=$(basename "$filepath")
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "dry-run: would upload ${basename}"
        return 0
    fi

    echo "Prepare upload ${basename}"
    jq -n --arg filename "$basename" '{filename: $filename}' > "$TV_WORKDIR/prepare.json"
    tv_api POST "/things/${THING_ID}/files" \
        -H "Content-Type: application/json" \
        --data @"$TV_WORKDIR/prepare.json"
    cp "$TV_BODY" "$TV_WORKDIR/prepare-response.json"

    echo "S3 upload ${basename}"
    s3_upload "$TV_WORKDIR/prepare-response.json" "$filepath" "$basename"

    echo "Finalize ${basename}"
    finalize_upload "$TV_WORKDIR/prepare-response.json"
}

append_release_notes() {
    local notes_file="$1"
    local tag="${RELEASE_TAG:-}"
    if [ -z "$tag" ]; then
        echo "RELEASE_TAG unset, skipping description append"
        return 0
    fi
    if [ -z "$notes_file" ] || [ ! -f "$notes_file" ]; then
        echo "No notes file, skipping description append"
        return 0
    fi

    # Heading that marks this tag's notes. Skip append if it is already present.
    local marker="## GitHub Release ${tag}"
    local notes
    notes=$(cat "$notes_file")
    if [ -z "$notes" ]; then
        notes="No release notes."
    fi

    echo "Fetching thing ${THING_ID} description"
    tv_api GET "/things/${THING_ID}"
    local current
    current=$(jq -r '.description // ""' "$TV_BODY")

    if printf '%s\n' "$current" | grep -qF "$marker"; then
        echo "Description already has ${marker}, leaving it"
        return 0
    fi

    local updated
    if [ -n "$current" ]; then
        # keep existing body, then marker, then notes. blank line between each.
        updated=$(printf '%s\n\n%s\n\n%s\n' "$current" "$marker" "$notes")
    else
        updated=$(printf '%s\n\n%s\n' "$marker" "$notes")
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "dry-run: would append notes block:"
        printf '%s\n\n%s\n' "$marker" "$notes"
        return 0
    fi

    echo "PATCH description with ${marker}"
    jq -n --arg description "$updated" '{description: $description}' > "$TV_WORKDIR/patch.json"
    tv_api PATCH "/things/${THING_ID}" \
        -H "Content-Type: application/json" \
        --data @"$TV_WORKDIR/patch.json"
}

# Collect local 3mf basenames
mapfile -t LOCAL_FILES < <(find "$LOCAL_DIR" -maxdepth 1 -type f -name '*.3mf' | sort)
if [ "${#LOCAL_FILES[@]}" -lt 1 ]; then
    echo "Error: no .3mf files in ${LOCAL_DIR}" >&2
    exit 1
fi

echo "Local 3mf files: ${#LOCAL_FILES[@]}"
for f in "${LOCAL_FILES[@]}"; do
    echo "  $(basename "$f")"
done
if [ "$DRY_RUN" -eq 1 ]; then
    echo "dry-run: no uploads or deletes will be sent"
fi

fetch_remote_files

failed=0
for filepath in "${LOCAL_FILES[@]}"; do
    name=$(basename "$filepath")
    existing_id=$(remote_id_for_name "$name")
    if [ -n "$existing_id" ]; then
        echo "Replace ${name} (remote id ${existing_id})"
        if ! delete_remote_file "$existing_id" "$name"; then
            echo "Error: failed to delete ${name} before replace" >&2
            failed=1
            break
        fi
    else
        echo "Add ${name}"
    fi
    if ! upload_file "$filepath"; then
        echo "Error: failed to upload ${name}" >&2
        failed=1
        break
    fi
done

if [ "$failed" -ne 0 ]; then
    echo "Stopping after upload error. Remote file set may be partial." >&2
    exit 1
fi

# delete files that are not in this release
fetch_remote_files
declare -A LOCAL_NAMES=()
for filepath in "${LOCAL_FILES[@]}"; do
    LOCAL_NAMES["$(basename "$filepath")"]=1
done

while IFS= read -r name; do
    [ -z "$name" ] && continue
    if [ -z "${LOCAL_NAMES[$name]+x}" ]; then
        extra_id=$(remote_id_for_name "$name")
        echo "Remote extra ${name} (id ${extra_id})"
        if ! delete_remote_file "$extra_id" "$name"; then
            echo "Error: failed to delete extra file ${name}" >&2
            exit 1
        fi
    fi
done < <(jq -r '.[].name' "$REMOTE_JSON")

if [ -n "$NOTES_FILE" ]; then
    append_release_notes "$NOTES_FILE"
fi

echo "Thingiverse sync complete for thing ${THING_ID}"
echo "https://www.thingiverse.com/thing:${THING_ID}/files"
