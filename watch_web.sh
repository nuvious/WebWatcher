#!/bin/bash
set -x

if [ ! -z ${var+SLEEP} ]; then
    echo "SLEEP variable must be set. $SLEEP"
    exit 1
fi

if [ ! -z ${var+FILTER} ]; then
    echo "FILTER variable must be set."
    exit 1
fi

if [ ! -z ${var+URL} ]; then
    echo "URL variable must be set."
fi

source lib/notify.sh

notify "Starting with filter $FILTER on $URL..."
while true; do
    curl -L --max-redirs 5 $URL > /data/curl.log
    count=$(grep "$FILTER" "/data/curl.log" | wc -l)
    echo "COUNT: $count"
    if [ $count -eq 0 ]; then
        notify "Filter for $FILTER failed on $URL."
    fi
    sleep $SLEEP
done
