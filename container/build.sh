#!/usr/bin/env bash
set -euox pipefail

cd "$(dirname "$0")"

git describe --tags --always --first-parent --match "NOT A TAG" --dirty=".DIRTY" --broken=".BROKEN" >../.git-described

build() {
  # TODO docker build --no-cache=true --pull -t ...
  docker build -t "$3" -f "$1"/"$2" "$1"/

  # Testing should never depend on user presence SK touch, so we clear SSH_AUTH_SOCK
  if [ -f "$1"/test ]; then
    SSH_AUTH_SOCK="" "$1"/test
  fi
}

#     Directory      Dockerfile        Image Tag Name
build fedora-updated Dockerfile        fedora-updated
build sshd           Dockerfile        sshd
build git-server     Dockerfile        git-server
build devshell       Dockerfile        devshell
build ..             Dockerfile-fedora gcr.io/vorburger/dotfiles-fedora
## build gcloud         Dockerfile        gcloud
