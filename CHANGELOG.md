# CHANGELOG

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
