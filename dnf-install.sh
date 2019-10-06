#!/usr/bin/env bash
set -euxo pipefail

sudo dnf install -y \
    asciinema \
    bash-completion \
    golang-bin git hub htop \
    java-1.8.0-openjdk-devel java-1.8.0-openjdk-src \
    java-11-openjdk-devel java-11-openjdk-src java-11-openjdk-jmods \
    nano mosh powerline-fonts trash-cli ShellCheck tmux wipe

sudo dnf remove "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
