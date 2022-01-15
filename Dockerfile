ARG ARCH=
FROM ${ARCH}alpine:latest

RUN apk add curl bash

ADD VERSION .

COPY app /app
COPY lib /lib
WORKDIR /app
CMD /bin/bash /app/watch_web.sh
