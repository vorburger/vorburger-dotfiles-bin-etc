#!/usr/bin/env bash
set -euxo pipefail

# This sets up the "homeless" config in containers for stuff outside of $HOME for all users.

cp etc/profile.d/PATH_HOME-bin.sh /etc/profile.d/
