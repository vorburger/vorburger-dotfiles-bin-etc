#!/usr/bin/env bash
set -euxo pipefail

brew install coreutils findutils nano fish bat

./git-clone.sh
./symlink.sh
