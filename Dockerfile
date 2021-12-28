from debian:bullseye

RUN apt-get update
RUN apt-get install curl -y

COPY . /app
WORKDIR /app
CMD /bin/bash /app/watch_web.sh
