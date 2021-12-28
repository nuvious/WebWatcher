docker build -t webwatcher .
docker run -d -v ${PWD}/data:/data --env-file ./env.list webwatcher
