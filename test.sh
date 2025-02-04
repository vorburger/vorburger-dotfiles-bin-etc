#!/usr/bin/env bash
set -euxo pipefail

container/build.sh
docker build -f Dockerfile-fedora .

docker build -f Dockerfile-google-cloud-workstation .
