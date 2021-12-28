# Web Watcher

This is just a simple docker container designed to watch a webpage for a
particular pattern and notify the user if that pattern is not present on the
page.

The default notification is via Pushover but that can be overridden. See
[advanced usage](#advanced-usage) for guidance on custom notification scripts.

## Requirements

- Docker

## Quickstart

Create an env.list file that specifies the following:

```bash
URL=[URL TO MONITOR WITHOUT QUOTES]
SLEEP=300s # A sleep between checks; ex 300s, 5m, 1h, etc
FILTER=SOLD.*OUT # A regex to pattern match
APP_TOKEN=[YOUR APP TOKEN] # Pushover app token
USER_KEY=[YOUR USER KEY] # Pushover user key
```

Create a data directory (dumps curl outputs for debugging) and launch the
container.

```bash
# Available in either launch.sh or launch.ps1 for windows.
mkdir -p data
docker build -t webwatcher .
docker run -d $PWD/data:/data --env-file env.list webwatcher
```

## Advanced Usage

### Override Notification Script

The script sources lib/notify.sh by default and this is a Pushover notification
implementation by default. This can be overridden using a simple volume mount
command as follows with any script that defines a notify() function:

```bash
docker run -d \
    -v $PWD/lib/notify_echo.sh:/app/lib/notify.sh \
    -v $PWD/data:/data \
    --env-file env.list webwatcher
```
