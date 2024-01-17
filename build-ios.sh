#!/bin/zsh

. ./build-common.sh

env=$(getEnv $?)
echo "env: $env"

git_commit=$(git rev-parse --short=8 HEAD)
if [ -f "versioning.json" ]; then
    echo "Delete versioning.json"
    rm -f versioning.json
fi

echo "Create versioning.json"
echo "{\"FLUTTER_BUILD_NAME_SUFFIX\": \"-$git_commit\", \"FLUTTER_BUILD_ENV\": \"+$env\"}" >> versioning.json
