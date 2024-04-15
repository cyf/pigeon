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
if [ -f "ios/Flutter/BuildConfig.xcconfig" ]; then
    echo "Delete ios/Flutter/BuildConfig.xcconfig"
    rm -f ios/Flutter/BuildConfig.xcconfig
fi

echo "Create ios/Flutter/BuildConfig.xcconfig"
echo "FLUTTER_BUILD_NAME_SUFFIX=-$git_commit" >> ios/Flutter/BuildConfig.xcconfig
echo "FLUTTER_BUILD_ENV=+$env" >> ios/Flutter/BuildConfig.xcconfig
