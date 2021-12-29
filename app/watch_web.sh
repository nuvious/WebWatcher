#!/bin/bash
set -x

if [ ! -z ${var+SLEEP} ]; then
    echo "SLEEP variable must be set. $SLEEP"
    exit 1
fi

if [ ! -z ${var+URL} ]; then
    echo "URL variable must be set."
fi

NOTIFY="/lib/$NOTIFY.sh"
MATCH="/lib/$MATCH.sh"
FORMATTER="/lib/$FORMATTER.sh"

if [ -f $NOTIFY ]; then
    source $NOTIFY
else
    echo "$NOTIFY not found."
    exit 1
fi

if [ -f $MATCH ]; then
    source $MATCH
else
    echo "$MATCH not found."
    exit 1
fi

if [ -f $FORMATTER ]; then
    source $FORMATTER
else
    echo "$FORMATTER not found."
    exit 1
fi

notify "Monitoring on $URL..."
while true; do
    curl -L --max-redirs 5 $URL > /data/curl.log
    match /data/curl.log
    if [ $? -eq 0 ]; then
        notify "$(format_message)"
    fi
    sleep $SLEEP
done
