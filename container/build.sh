#!/usr/bin/env bash
set -euox pipefail

cd "$(dirname "$0")"

build() {
  docker build -t $1 $1/
}

build fedora-updated
build sshd
build gcloud
