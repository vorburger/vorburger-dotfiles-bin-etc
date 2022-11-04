#!/usr/bin/env bash
set -euxo pipefail

sudo pacman -S --needed --noconfirm kitty

# only pacman packages installation is here, other installations are in all-install.sh
./all-install.sh
