#!/usr/bin/env bash
set -euox pipefail

cd "$(dirname "$0")"

build() {
  # podman build --no-cache=true --pull -t $2 $1/
  podman build -t $2 $1/
  $1/test
}

build fedora-updated fedora-updated
build sshd           sshd
build devshell       devshell
build gcloud         gcloud
build ..             vorburger
