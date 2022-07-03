#!/usr/bin/env bash
set -euxo pipefail

# This is Debian specific; see ubuntu-install.sh for Ubuntu specific stuff, and apt-install.sh for stuff that's common to Debian and Ubuntu.

if [ $# -ne 1 ]; then
    echo "Usage: $0 <Debian-Version> (9.0, 10, 11)"
    echo "E.g. $0 11"
    exit 1
fi
DEBIAN_VERSION=$1

# https://fishshell.com =>
# https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
# (because Debian 11 packages an ancient Fish v3.1.2 which is 1.5 years behind)
sudo apt install -y curl gpg
echo "deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_$DEBIAN_VERSION/ /" | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL "https://download.opensuse.org/repositories/shells:fish:release:3/Debian_$DEBIAN_VERSION/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
# NB this ^^^ must be done BEFORE the apt update that comes NEXT

./apt-install.sh