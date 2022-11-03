#!/usr/bin/env bash
set -euxo pipefail

pacman -S kitty

# only pacman packages installation is here, other installations are in all-install.sh
./all-install.sh
