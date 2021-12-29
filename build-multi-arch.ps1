# If any command fails, stop the script
$ErrorActionPreference = "Stop"

# Login to docker
docker login

$USERNAME="nuvious"
$IMAGE="webwatcher"
$VERSION = Get-Content VERSION -Raw 

# Push changes to git
git add -A
git commit -m "Release $version"
git tag -a "$version" -m "Release $version"
git push
git push --tags

# Build a 'latest' tagged image
docker buildx build `
    --push `
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 `
    --tag ${USERNAME}/${IMAGE}:latest .

# Build a version tagged image
docker buildx build `
    --push `
    --platform linux/arm/v7,linux/arm64/v8,linux/amd64 `
    --tag ${USERNAME}/${IMAGE}:${VERSION} .
