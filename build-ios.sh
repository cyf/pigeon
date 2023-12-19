#!/bin/zsh

. ./build-common.sh

env=$(getEnv $?)
echo "env: $env"

git_commit=$(git rev-parse --short=8 HEAD)
if [ -f "adhoc.json" ]; then
    echo "Delete adhoc.json"
    rm -f adhoc.json
fi

echo "Create adhoc.json"
echo "{\"FLUTTER_BUILD_NAME_SUFFIX\": \"-$git_commit\", \"FLUTTER_BUILD_ENV\": \"+$env\"}" >> adhoc.json
