#!/usr/bin/env bash
set -euxo pipefail

rpm-ostree install \
    google-chrome \
    kitty \
    podman-docker

