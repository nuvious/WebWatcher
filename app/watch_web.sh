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
DATA_DIR="/data"

mkdir -p $DATA_DIR


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

if [ ! -z "$URLS" ]; then
    urls=($URLS)
else
    echo "URLS not found."
    exit 1
fi

if [ ! -z  "$FILTERS" ]; then
    filters=($FILTERS)
else
    echo "FILTERS not found."
    exit 1
fi

if [ -z  "$SLEEP" ]; then
    echo "SLEEP not found."
    exit 1
fi

if [ -z  "$DELAY" ]; then
    echo "DELAY not found."
    exit 1
fi

if [ ${#filters[@]} -ne ${#urls[@]} ]; then
    echo "URLS (${#urls[@]}) and FILTERS (${#filters[@]}) must be the same number of elements."
    echo $urls
    echo $filters
    exit 1
fi

notify "Monitoring on $URLS..."
while true; do
    for i in "${!urls[@]}"; do
        URL=${urls[$i]}
        FILTER=${filters[$i]}
        curl -L --max-redirs 5 $URL > $DATA_DIR/curl.log
        match $DATA_DIR/curl.log
        if [ $? -eq 0 ]; then
            notify "$(format_message)"
        fi
        sleep $DELAY
    done
    sleep $SLEEP
done
