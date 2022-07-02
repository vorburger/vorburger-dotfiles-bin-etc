#!/usr/bin/env bash
set -euox pipefail

podman rm -f dotfiles || true
podman run -d --rm --name dotfiles -p 2222:2222 gcr.io/vorburger/dotfiles-fedora:latest
