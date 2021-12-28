<#
USAGE:
    .\launch.ps1 `
        -match [PATH_TO_MATCH_SCRIPT] `
        -notify [PATH_TO_NOTIFY_SCRIPT] `
        -msgformatter [PATH_TO_MESSAGE_FORMAT_SCRIPT] `
        -envfile [PATH_TO_ENV_FILE] `
        -name [HUMAN_READABLE_INSTANCE_NAME] `
        -data [DATA_DIR]

    Ex:

    .\launch.ps1 `
        -match lib\match_grep_regex.sh `
        -notify lib\notify_pushover.sh `
        -msgformatter lib\default_formatter.sh `
        -envfile env-bestbuy-xbox.list `
        -name xbox-in-stock-watcher-bestbuy
        -data .\data
#>

param($notify, $match, $name, $envfile, $data, $msgformatter)

Write-Host "$name, $notify, $match, $envfile, $data"

New-Item -ItemType Directory -Force -Path $data
docker build -t webwatcher .
docker run `
    -d `
    --restart unless-stopped `
    -v ${data}:/data `
    -v ${notify}:/app/lib/notify.sh `
    -v ${match}:/app/lib/match.sh `
    -v ${msgformatter}:/app/lib/msg.sh `
    --env-file $envfile `
    --name $name `
    webwatcher
