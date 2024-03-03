#!/usr/bin/env bash
set -euxo pipefail

# This sets up dotfiles in GitHub Codespaces, see
# https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles

./ubuntu-install.sh

# ubuntu-install.sh ends with apt-install.sh which ends with all-install.sh, so no need to redo:
# ./all-install.sh

./symlink.sh
