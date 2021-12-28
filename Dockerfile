from debian:bullseye

RUN apt-get update
RUN apt-get install curl -y

ADD VERSION .

COPY /app /app
WORKDIR /app
CMD /bin/bash /app/watch_web.sh
