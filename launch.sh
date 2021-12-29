#!/bin/bash
NAME=$1
ENV_FILE=$2
DATA_DIR=$3

mkdir -p $DATA_DIR
docker build -t webwatcher .
docker run \
    -d \
    -v $DATA:/data \
    --name $NAME
    --env-file $ENV_FILE \
    webwatcher
