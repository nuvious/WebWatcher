# Deploy to Azure

This will outline the process to deploy a container to Azure

## Procedure

1. Login to azure via docker

`docker login azure`

2. Create an ACI

`docker context create aci webwatcher-aci`

3. Run the container

```bash
docker --context webwatcher-aci run \
    --env-file env.list \
    --name webwatcher-azure \
    nuvious/webwatcher:latest
```