#!/usr/bin/env bash
set -euox pipefail

podman volume exists home-git || podman volume create home-git

podman rm --force --time=1 dotfiles || true
podman run -d --name dotfiles -p 2222:2222 \
    -v home-git:/home/vorburger/git \
    -v /run/user/$UID/podman:/run/user/1000/podman --security-opt label=disable \
    gcr.io/vorburger/dotfiles-fedora:latest
