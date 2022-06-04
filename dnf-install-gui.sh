#!/usr/bin/env bash
set -euxo pipefail

sudo dnf install -y \
    kitty ImageMagick \
    gnome-tweak-tool \
    android-tools

sudo dnf remove "libreoffice*"

# only DNF is here, other installations are in all-install.sh
./all-install.sh

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
