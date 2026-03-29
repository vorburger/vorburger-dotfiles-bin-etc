#!/usr/bin/env bash
set -euxo pipefail

# As in .github/workflows:
docker build -f Dockerfile-nix-devcontainer-codespace .
docker build -f Dockerfile-debian13_trixie-codespace .
docker build -f Dockerfile-debian12_bookworm-codespace .

# OLD!
#container/build.sh
#docker build -f Dockerfile-fedora .
#docker build -f Dockerfile-google-cloud-workstation .
