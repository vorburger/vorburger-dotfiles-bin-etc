#!/usr/bin/env bash
set -euxo pipefail

./setup.sh

./git-install.sh

./dnf-install.sh

# https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
if [ ! -s /usr/bin/code ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  dnf check-update
fi

sudo dnf install -y \
    pass kitty code powertop \
    ImageMagick \
    gnome-tweak-tool \
    android-tools

sudo dnf remove "libreoffice*"

./all-install.sh

./symlink.sh

./gnome-settings.sh

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
