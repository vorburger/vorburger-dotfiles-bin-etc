#!/usr/bin/env bash
set -euxo pipefail

# ALWAYS invoke bootstrap.sh instead of directly this, as it will dispatch Debian -VS- Ubuntu correctly.

# This is Ubuntu specific; see debian-install.sh for Debian specific stuff, and apt-install.sh for stuff that's common to Ubuntu and Debian.

function install_fish {
  if [ ! "$(command -v apt-add-repository)" ]; then
    sudo apt-get update -y
    sudo apt-get install -y software-properties-common
  fi

  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt-get update -y

  # Do *NOT* run upgrade (only update) in GitHub Codespaces or GCP WS, because it's SO SLOW
  if [[ -z "${CODESPACES:-}" && -z "${GOOGLE_CLOUD_WORKSTATIONS:-}" ]]; then
    sudo apt-get upgrade -y
  fi

  sudo apt-get install -y fish
  fish --version
}

if [ ! "$(command -v fish)" ]; then
  install_fish
else

  # https://fishshell.com =>
  # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+packages
  # (because Ubuntu 20.04 LTS packages an ancient Fish v3.1.0 which is 1.5+ years behind current >v3.3+)

  FISH_VERSION=$(fish --version | cut -c 15-)
  if $(dpkg --compare-versions $FISH_VERSION lt 3.5.1); then
    echo "Fish version is <3.5.1, so upgrading it..."
    sudo apt-get remove -y fish fish-common

    install_fish
  else
    echo "Fish version is >=3.5.1, great!"
  fi
fi

./apt-install.sh
