#!/bin/zsh

function getEnv() {
  env=""
  if [ "$(awk '/dev.external.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="development"
  elif [ "$(awk '/dev.internal.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="development"
  elif [ "$(awk '/stg.external.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="staging"
  elif [ "$(awk '/stg.internal.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="staging"
  elif [ "$(awk '/external.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="production"
  elif [ "$(awk '/internal.homing-pigeon.chenyifaer.com/{print $0}' .env)" ]; then
      env="production"
  fi
  echo "$env"
}
