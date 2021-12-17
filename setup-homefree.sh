#!/usr/bin/env bash
set -euxo pipefail

# Set up the "homefree" config in containers for stuff outside of $HOME for all users.

cp -R /etc/fish /etc/fish.original
cp -R "$(dirname "$0")"/dotfiles/fish /etc/

# NOT WORKING: cp "$(dirname "$0")"/etc/profile.d/PATH_HOME-bin.sh /etc/profile.d/
