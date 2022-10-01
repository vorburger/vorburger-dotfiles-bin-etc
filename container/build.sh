#!/usr/bin/env bash
set -euox pipefail

cd "$(dirname "$0")"

build() {
  # docker build --no-cache=true --pull -t $2 $1/
  docker build -t $3 -f $1/$2 $1/
  ## $/test TODO re-enable once it not depend on user presence SK touch
}

#     Directory      Dockerfile        Image Tag Name
build fedora-updated Dockerfile        fedora-updated
build sshd           Dockerfile        sshd
build devshell       Dockerfile        devshell
build ..             Dockerfile-fedora gcr.io/vorburger/dotfiles-fedora
build toolbox        Dockerfile        dotfiles-fedora-toolbox
## build gcloud         Dockerfile        gcloud
