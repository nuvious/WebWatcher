#!/bin/bash

notify(){
    if [ ! -z ${var+APP_TOKEN} ]; then
        echo "APP_TOKEN must be set."
        exit 1
    fi

    if [ ! -z ${var+USER_KEY} ]; then
        echo "USER_KEY must be set."
        exit 1
    fi

    curl -s \
    --form-string "token=$APP_TOKEN" \
    --form-string "user=$USER_KEY" \
    --form-string "message=$1" \
    --form-string "priority=1" \
    https://api.pushover.net/1/messages.json
}
