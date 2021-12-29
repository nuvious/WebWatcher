# Web Watcher Libs

This documents the available match, notify and formatter scripts that come
stock with this docker container.

## Match Scripts

### match_grep_regex.sh

#### Env File Params

Triggers a match on a curl output when a regex matches at least once.

```bash
MATCH=match_grep_regex
FILTER=[SOME_REGEX]
```

## match_grep_regex_negative.sh

#### Env File Params

Triggers a match on a curl output when a regex does not match.

```bash
MATCH=match_grep_regex
FILTER=[SOME_REGEX]
```

## Notify Scripts

### notify_pushover.sh

#### Env File Params

```bash
NOTIFY=notify_pushover
APP_TOKEN=[PUSHOVER_APP_TOKEN]
USER_KEY=[PUSHOVER_USER_KEY]
```

## Formatter Scripts

### default_formatter.sh

#### Env File Params

Produces an output of "Match condition on $URL" for the notification script.

```bash
FORMATTER=default_formatter
```

### formatter_grep_match.sh

#### Env File Params

Produces an output of "Match condition on $URL with regex expr $FILTER." for
the notification script.

```bash
FORMATTER=formatter_grep_match
```