#!/usr/bin/env bash
set -euxo pipefail

if [ ! -s ~/.ssh/authorized_keys ]; then
  # Similar to Dockerfile-fedora
  curl https://github.com/vorburger.keys > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
else
  echo "~/.ssh/authorized_keys already exists; rm it to have this script set them"
fi
