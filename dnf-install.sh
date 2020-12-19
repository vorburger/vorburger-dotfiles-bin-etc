#!/usr/bin/env bash
set -euxo pipefail

sudo dnf install -y \
    asciinema \
    bash-completion \
    golang-bin git hub htop \
    java-1.8.0-openjdk-devel java-1.8.0-openjdk-src \
    java-11-openjdk-devel java-11-openjdk-src java-11-openjdk-jmods \
    nano mosh powerline-fonts trash-cli ShellCheck tmux wipe \
    fira-code-fonts mozilla-fira-mono-fonts \
    kitty ImageMagick \
    gnome-tweak-tool \
    lsd fish autojump-fish autojump-zsh autojump

[ -s /usr/local/bin/starship ] || curl -fsSL https://starship.rs/install.sh | bash

sudo dnf remove "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
