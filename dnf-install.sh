#!/usr/bin/env bash
set -euxo pipefail

sudo dnf install -y \
    asciinema \
    bash-completion \
    golang git hub htop \
    java-1.8.0-openjdk-devel java-1.8.0-openjdk-src \
    java-11-openjdk-devel java-11-openjdk-src java-11-openjdk-jmods \
    powerline-fonts trash-cli ShellCheck tmux wipe wl-clipboard \
    fira-code-fonts mozilla-fira-mono-fonts \
    lsd fish autojump-fish autojump-zsh autojump fzf fd-find bat \
    automake autoconf texinfo gettext-devel ncurses-devel \
    pwgen diceware \
    cargo \
    kubernetes-client

sudo dnf remove "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
