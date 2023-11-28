#!/bin/zsh

. ./build-common.sh

env=$(getEnv $?)
echo "env: $env"

git_commit=$(git rev-parse --short=8 HEAD)
if [ -f "ios-pgyer.json" ]; then
    echo "Delete ios-pgyer.json"
    rm -f ios-pgyer.json
fi

echo "Create ios-pgyer.json"
echo "{\"FLUTTER_BUILD_NAME_SUFFIX\": \"-$git_commit\", \"FLUTTER_BUILD_ENV\": \"+$env\"}" >> ios-pgyer.json
