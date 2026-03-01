#!/usr/bin/env bash
set -euxo pipefail

# ALWAYS invoke bootstrap.sh instead of directly this, as it will dispatch Debian -VS- Ubuntu correctly.

# This is Debian specific; see ubuntu-install.sh for Ubuntu specific stuff, and apt-install.sh for stuff that's common to Debian and Ubuntu.

# This must be the "numeric" Debian version (like 12, 11 or 10) and not the "code name" (like bullseye/sid)
# It does not seem to be possible to obtain this as a number when we're running on a (Debian-based) Ubuntu, where this is the Debian name not number.
DEBIAN_MAJOR_VERSION=$(cut -d'.' -f1 /etc/debian_version)

# https://fishshell.com =>
# https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
# (because Debian 11 packages an ancient Fish v3.1.2 which is 1.5 years behind)
sudo apt-get install -y curl wget gpg
# Remove stale yarnpkg repo which has an invalid GPG key and causes apt-get update to fail
sudo rm -f /etc/apt/sources.list.d/yarnpkg.list
# NB: Do curl *first* so that if it fails we don't "pollute" /etc/apt/sources.list.d/ (which we intentionally do only after)
curl -fsSL "https://download.opensuse.org/repositories/shells:fish:release:3/Debian_$DEBIAN_MAJOR_VERSION/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
echo "deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_$DEBIAN_MAJOR_VERSION/ /" | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list

sudo apt-get update -y
sudo apt-get install -y fish

./apt-install.sh
