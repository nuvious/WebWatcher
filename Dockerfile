from alpine:latest

RUN apk add curl

ADD VERSION .

COPY app /app
COPY lib /lib
WORKDIR /app
CMD /bin/sh /app/watch_web.sh
