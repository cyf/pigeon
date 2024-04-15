#!/bin/zsh

. ./build-common.sh

env=""
if [ ! -z "$1" ]; then
    echo "get env from args"
    env="$1"
else
    echo "get env from .env"
    env=$(getEnv $?)
fi

echo "env: $env"

git_commit=$(git rev-parse --short=8 HEAD)
if [ -f "android/versioning.properties" ]; then
    echo "Delete android/versioning.properties"
    rm -f android/versioning.properties
fi

echo "Create android/versioning.properties"
echo "app.env=$env" >> android/versioning.properties
echo "app.suffix=$git_commit" >> android/versioning.properties
