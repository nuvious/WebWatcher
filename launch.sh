#!/bin/bash
mkdir -p data
docker build -t webwatcher .
docker run -d $PWD/data:/data --env-file env.list webwatcher
