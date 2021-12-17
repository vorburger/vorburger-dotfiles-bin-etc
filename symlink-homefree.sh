#!/usr/bin/env bash
set -euxo pipefail

# Set up the "homefree" config for containers with dotfiles in / instead of /home
# so that it works for all and any users and with an empty host-mounted $HOME.
# This is useful e.g. in Toolbox and Google Cloud Shell and similar.

cp -R /etc/fish /etc/fish.original
cp -R "$(dirname "$0")"/dotfiles/fish /etc/

# NOT WORKING: cp "$(dirname "$0")"/etc/profile.d/PATH_HOME-bin.sh /etc/profile.d/
