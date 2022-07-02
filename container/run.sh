#!/usr/bin/env bash
set -euox pipefail

podman volume exists home-git || podman volume create home-git

podman rm -f dotfiles || true
podman run -d -v home-git:/home/vorburger/git --name dotfiles -p 2222:2222 gcr.io/vorburger/dotfiles-fedora:latest
