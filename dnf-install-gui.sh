#!/usr/bin/env bash
set -euxo pipefail

./setup.sh

./git-install.sh

./dnf-install.sh

sudo dnf install -y \
    kitty ImageMagick \
    gnome-tweak-tool \
    android-tools

sudo dnf remove "libreoffice*"

./all-install.sh

./symlink.sh

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
