$USERNAME=$args[0]
$IMAGE="webwatcher"
Write-Host "Building to tag $USERNAME/webwatcher:latest"
docker build -t "$USERNAME/webwatcher:latest" .