# Web Watcher

This is just a simple docker container designed to watch a webpage for a
particular pattern and notify the user if that pattern is not present on the
page.

## Quickstart

Create an env.list file that specifies the following:

```bash
URL=www.shopingforsomethinginhighdemand.com # Some URL to monitor
SLEEP=5m # A sleep between checks; ex 30, 5m, 1h, etc

FORMATTER=grep_match_formatter # Use the grep specific formatter

MATCH=match_grep_regex_negative  # Use the negative grep regex matcher
FILTER=SOLD.*OUT # A regex to pattern match

NOTIFY=notify_pushover # Use the pushover notifier script
APP_TOKEN=[YOUR APP TOKEN] # Pushover app token
USER_KEY=[YOUR USER KEY] # Pushover user key
```

The above example does a negative regex match on the regex SOLD.*OUT and
notifies the user via pushover if the REGEX does not match the specified url.
There are different scripts available for different notification mechanisms,
match conventions, and formatting. For details see the
[script library documentation](lib/README.md).

Create a data directory (dumps curl outputs for debugging) and launch the
container.

```bash
# Available in either launch.sh or launch.ps1 for windows.
mkdir -p data
docker build -t webwatcher .
docker run \
    -d \
    -v $PWD/data:/data \
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
    -envfile ${PWD}/env-xbox-bestbuy-instock.list `
    -name bestbuy-xbox `
    -data ${PWD}/data
```

### launch.sh Helper

Usage Example:

```bash
# NOTE: Launch options for the bash script are ordered
.\launch.sh \
    "container-name" \ # The name for the container
    $PWD/data \ # The data directory for the container
    $PWD/env-xbox-bestbuy-instock.list # The environment file to use
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
