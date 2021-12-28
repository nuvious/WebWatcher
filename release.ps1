$ErrorActionPreference = "Stop"

docker login

$USERNAME="nuvious"
$IMAGE="webwatcher"

$version = Get-Content VERSION -Raw 
echo "version: $version"

# run build
. ./build.ps1

# tag it
git add -A
git commit -m "Release $version"
git tag -a "$version" -m "Release $version"
git push
git push --tags
docker tag ${USERNAME}/${IMAGE}:latest ${USERNAME}/${IMAGE}:$version

# push it
docker push ${USERNAME}/${IMAGE}:latest
docker push ${USERNAME}/${IMAGE}:$version