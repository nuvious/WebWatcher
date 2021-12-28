#!/bin/bash
set -x

if [ ! -z ${var+SLEEP} ]; then
    echo "SLEEP variable must be set. $SLEEP"
    exit 1
fi

if [ ! -z ${var+URL} ]; then
    echo "URL variable must be set."
fi

source lib/notify.sh
source lib/match.sh
source lib/msg.sh

notify "Monitoring on $URL..."
while true; do
    curl -L --max-redirs 5 $URL > /data/curl.log
    match /data/curl.log
    if [ $? -eq 0 ]; then
        notify "$(format_message)"
    fi
    sleep $SLEEP
done
