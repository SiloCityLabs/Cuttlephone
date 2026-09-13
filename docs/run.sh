#!/bin/bash

# load .env
env_file="$(dirname "$0")/.env"
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
