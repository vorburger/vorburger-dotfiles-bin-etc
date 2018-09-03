#!/bin/sh
set -euxo pipefail

sudo dnf remove "libreoffice*"

sudo dnf install git nano java-devel java-1.8.0-openjdk-src chromium zsh p7zip p7zip-plugins keepassxc docker-zsh-completion powerline-fonts asciinema youtube-dl kernel-tools
