#!/usr/bin/env bash
set -euxo pipefail

docker build -t vorburger-toolbox -f Dockerfile-toolbox .
docker stop --time=1 vorburger-toolbox || true
docker rm --force vorburger-toolbox || true
toolbox create -i vorburger-toolbox
toolbox enter vorburger-toolbox

