#!/usr/bin/env bash
set -euox pipefail

cd "$(dirname "$0")"

build() {
  docker build -t $1 $1/
  $1/test
}

build fedora-updated
build sshd
build devshell
build gcloud
