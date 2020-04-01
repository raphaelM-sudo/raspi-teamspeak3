#!/bin/bash

if [ "$1" -ge 1 ] && [ "$1" -le 4 ] && [ "$2" != "" ]; then
    docker build --no-cache -t exapi --build-arg PI_VERSION=$1 https://github.com/raphaelM-sudo/ExaPi.git \
    && docker-compose build --no-cache --build-arg EXAPI_IMAGE=exapi --build-arg TEAMSPEAK_VERSION=$2 \
    && docker-compose up --force-recreate
else
    echo "Usage: \"./easy-install.sh <PI_VERSION> <TS3_VERSION>\""
fi

