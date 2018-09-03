#!/bin/sh
set -euxo pipefail

# TODO how to avoid failure ("Error: No packages marked for removal.") if already removed?
# sudo dnf remove "libreoffice*"

sudo dnf install mc git nano java-devel java-1.8.0-openjdk-src chromium zsh p7zip p7zip-plugins keepassxc docker-zsh-completion powerline-fonts asciinema youtube-dl kernel-tools
