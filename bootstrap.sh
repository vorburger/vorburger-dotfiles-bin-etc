#!/usr/bin/env bash
set -euxo pipefail

# This sets up dotfiles in GitHub Codespaces, see
# https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles

# ./apt-install.sh is intentionally *NOT* invoked here, because the GitHub Codespace default dev container
# (https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/introduction-to-dev-containers)
# already includes some of what apt-install.sh would re-install.

# TODO factor out lsd and bat installation from ./apt-install.sh?

./all-install.sh

# TODO alias e open Codespace editor (how?), instead of nano?
