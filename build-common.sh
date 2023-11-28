#!/bin/zsh

function getEnv() {
  env=""
  if [ "$(awk '/dev.chenyifaer.com/{print $0}' .env)" ]; then
      env="development"
  elif [ "$(awk '/stg.chenyifaer.com/{print $0}' .env)" ]; then
      env="staging"
  elif [ "$(awk '/www.chenyifaer.com/{print $0}' .env)" ]; then
      env="production"
  fi
  echo "$env"
}
