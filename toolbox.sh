#!/usr/bin/env bash
set -euxo pipefail

docker build -t vorburger-toolbox -f Dockerfile-toolbox .
docker rm -f vorburger-toolbox
toolbox create -i vorburger-toolbox
toolbox enter vorburger-toolbox
