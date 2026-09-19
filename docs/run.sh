#!/bin/bash

docs_dir="$(dirname "$0")"

# copy config for names and build flags
cp "$docs_dir/../phone_case.json" "$docs_dir/_data/phone_case.json"

# load .env
env_file="$docs_dir/.env"
if [ -f "$env_file" ]
then
    # export every assignment in the file
    set -a
    . "$env_file"
    set +a
fi

# don't send empty token
if [ -z "$JEKYLL_GITHUB_TOKEN" ]
then
    unset JEKYLL_GITHUB_TOKEN
fi

bundle exec jekyll serve --incremental
