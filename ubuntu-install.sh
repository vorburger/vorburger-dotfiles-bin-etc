#!/usr/bin/env bash
set -euxo pipefail

# This is Ubuntu specific; see debian-install.sh for Debian specific stuff, and apt-install.sh for stuff that's common to Ubuntu and Debian.

# https://fishshell.com =>
# https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+packages
# (because Ubuntu 20.04 LTS packages an ancient Fish v3.1.0 which is 1.5+ years behind current >v3.3+)

FISH_VERSION=$(fish --version | cut -c 15-)
if $(dpkg --compare-versions $FISH_VERSION lt 3.5.1); then
    echo "Fish version is <3.5.1, so upgrading it..."
    sudo apt-get remove -y fish fish-common

    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install -y fish
    fish --version
else
    echo "Fish version is >=3.5.1, great!"
fi

./apt-install.sh
