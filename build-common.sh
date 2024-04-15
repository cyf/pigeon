#!/bin/zsh

function getEnv() {
  env=""
  if [ "$(awk '/dev.chenyifaer.com\/homing-pigeon/{print $0}' .env)" ]; then
      env="development"
  elif [ "$(awk '/stg.chenyifaer.com\/homing-pigeon/{print $0}' .env)" ]; then
      env="staging"
  elif [ "$(awk '/chenyifaer.com\/homing-pigeon/{print $0}' .env)" ]; then
      env="production"
  fi
  echo "$env"
}
