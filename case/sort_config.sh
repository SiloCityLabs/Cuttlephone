#! /bin/bash

# sort the JSON config to avoid mangling the git hisory
# this file is for running manually to see "git diff" properly
# and identical script will run pre-commit with a git hook
jq -S '.' phone_case.json > phone_case.json;