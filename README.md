# Web Watcher

This is just a simple docker container designed to watch a webpage for a
particular pattern and notify the user if that pattern is not present on the
page.

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

The above is based on the notify_pushover.sh notification script. Variables
needed to be specified in the env.list file may vary depending on the
notification script of choice.

Create a data directory (dumps curl outputs for debugging) and launch the
container. When launching the container map scripts in lib (or any other
location) to teh match.sh, notify.sh, and msg.sh scripts respectively. This
allows launching multiple instances with different match conventions,
notification actions, and message formats. For more information see the section
on [advanced usage](#advanced-usage).

```bash
# Available in either launch.sh or launch.ps1 for windows.
mkdir -p data
docker build -t webwatcher .
docker run \
    -d \
    -v $PWD/data:/data \
    -v $PWD/lib/match_grep_regex.sh:/app/lib/match.sh \
    -v $PWD/lib/notify_pushover.sh:/app/lib/notify.sh \
    -v $PWD/lib/default_formatter.sh:/app/lib/msg.sh \
    --env-file env.list \
    webwatcher
```

Launch helper scripts have also been generated in bash and powershell that build
the container and launch it with specified environment file, match, notify, and 
msg format scripts.

### launch.ps1 Helper

Usage Example:

```powershell
.\launch.ps1 `
    -match ${PWD}/lib/match_grep_regex.sh `
    -notify ${PWD}/lib/notify_pushover.sh `
    -envfile ${PWD}/env-xbox-bestbuy-instock.list `
    -msgformatter ${PWD}/lib/default_formatter.sh `
    -name bestbuy-xbox `
    -data ${PWD}/data
```

### launch.sh Helper

Usage Example:

```bash
# NOTE: Launch options for the bash script are ordered
.\launch.sh \
    $PWD/lib/match_grep_regex.sh \
    -notify $PWD/lib/notify_pushover.sh \
    -envfile $PWD/env-xbox-bestbuy-instock.list \
    -msgformatter $PWD/lib/default_formatter.sh \
    -name bestbuy-xbox \
    -data $PWD/data
```

## Advanced Usage

### Override Notification Script

The script sources lib/notify.sh on startup to import a notify() function.
This can be overridden using a simple volume mount command as follows with any
script that defines a notify() function. The notify() function should not exit
and should return nothing; it simply takes the input from $1 and uses it to
notify the user via the means implemented in the funciton itself.

### Override Match Script

The script sources lib/match.sh by default. The match script defines a match()
function which takes a file in the $1 argument and returns 0 if there's a match
or 1 for a non-match. All other parameters should be passed in via environment
variables and null-checking these variables should be handled in the script
itself.

### Override Message Format Script

The script sources lib/msg.sh by default. The msg script defines a
format_message() function which outputs a message to stdout. It should develop
its formatted response based on the available environmental variables. Variables
which can be relied upon as an example are $URL and $SLEEP. All other variables
are related to the match and notification scripts and one may want to develop
message format scripts specific to how output of the curl command is processed
in match and the available conventions of the notification script.
