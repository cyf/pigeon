#!/bin/zsh

. ./build-common.sh

env=$(getEnv $?)
echo "env: $env"

git_commit=$(git rev-parse --short=8 HEAD)
if [ -f "android/git.properties" ]; then
    echo "Delete android/git.properties"
    rm -f android/git.properties
fi

echo "Create android/git.properties"
echo "app.env=$env" >> android/git.properties
echo "app.suffix=$git_commit" >> android/git.properties
