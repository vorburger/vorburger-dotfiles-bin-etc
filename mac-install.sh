#!/usr/bin/env bash
set -euxo pipefail

brew install coreutils nano fish

./git-install.sh
./symlink.sh
