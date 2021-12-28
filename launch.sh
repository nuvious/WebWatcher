#!/bin/bash
MATCH=$1
NOTIFY=$2
MSGFORMAT=$3
ENV_FILE=$4
DATA_DIR=$5

mkdir -p $DATA_DIR
docker build -t webwatcher .
docker run \
    -d \
    -v $MATCH:/app/lib/match.sh \
    -v $NOTIFY:/app/lib/notify.sh \
    -v $MSGFORMAT:/app/lib/msg.sh \
    -v $DATA:/data \
    --env-file $ENV_FILE \
    webwatcher
