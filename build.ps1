$USERNAME=$args[0]
$IMAGE="webwatcher"
Write-Host "Building to tag ${USERNAME}/${IMAGE}:latest"
docker build -t "${USERNAME}/${IMAGE}:latest" .
