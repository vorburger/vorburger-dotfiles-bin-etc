#!/usr/bin/env bash
set -euxo pipefail

# This sets up the "homefree" config in containers for stuff outside of $HOME for all users.

cp "$(dirname "$0")"/etc/profile.d/PATH_HOME-bin.sh /etc/profile.d/
