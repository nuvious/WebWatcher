<#
USAGE:
    .\launch.ps1 `
        -envfile [PATH_TO_ENV_FILE] `
        -name [HUMAN_READABLE_INSTANCE_NAME] `
        -data [DATA_DIR]

    Ex:

    .\launch.ps1 `
        -envfile env-bestbuy-xbox.list `
        -name xbox-in-stock-watcher-bestbuy
        -data .\data
#>

param($name, $envfile, $data)

New-Item -ItemType Directory -Force -Path ${data}
docker build -t webwatcher .
docker run `
    -d `
    -v ${data}:/data `
    --env-file ${envfile} `
    --name ${name} `
    webwatcher
