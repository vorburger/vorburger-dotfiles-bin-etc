#!/usr/bin/env bash
set -euxo pipefail

podman build -t vorburger-toolbox -f Dockerfile-toolbox .
podman rm -f vorburger-toolbox
toolbox create -i vorburger-toolbox
toolbox enter vorburger-toolbox
