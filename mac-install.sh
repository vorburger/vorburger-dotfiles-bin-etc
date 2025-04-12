#!/usr/bin/env bash
set -euxo pipefail

brew install coreutils findutils nano fish bat

./git-install.sh
./symlink.sh
