# CHANGELOG

## 2.0.4 - 2021-12-29

- Updated documentation links so they would work in dockerhub.
- Fixed launch.ps1 documentation to remove some outdated flags in comments for
  usage.

## 2.0.3 - 2021-12-29

- Switched to alpine.

## 2.0.2 - 2021-12-29

- Added apt-get upgrade to dockerfile build to mitigate vulnerabilities.

## 2.0.1 - 2021-12-29

- Fixed bug where data directory wasn't beind 

## 2.0.0 - 2021-12-29

- Modified version since 1.0.2 is a breaking change.

## 1.0.2 - 2021-12-29

- Removed necessity for deployments to mount scripts via volumes to notify.sh,
  msg.sh, and match.sh respectively. It's still possible to load custom scripts
  via volume mounts but not required. Make this easier to deploy to cloud
  environments using stock scripts.

## 1.0.1 - 2021-12-28

- Initial versioned docker image
- Added functionality to override message format
- Added build/release scripts for pushing container to dockerhub
- Added a changelog
- Updated launch helper scripts and documentation for them
