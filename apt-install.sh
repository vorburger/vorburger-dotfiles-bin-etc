#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get update && sudo apt-get dist-upgrade -y

# see install-nano.sh (which install.sh only invokes if there is no /usr/bin/nano)
sudo apt remove -y nano

sudo apt install -y \
    bash-completion file git hub htop procps unzip \
    trash-cli shellcheck tmux wipe \
    fish autojump fzf fd-find \
    cargo curl wget \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev

sudo apt autoremove -y

# NOT golang, as it's too old on Debian Stable; better always grab a fixed version from golang.org in install.sh

# TODO https://github.com/wting/autojump#linux /usr/share/doc/autojump/README.Debian

# https://github.com/Peltoche/lsd
# TODO automatically download latest version instead of hard-coding
if [ ! -f /usr/bin/lsd ]; then
    wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
    sudo dpkg -i lsd_0.20.1_amd64.deb
fi

# https://github.com/sharkdp/bat
# TODO automatically download latest version instead of hard-coding
if [ ! -f /usr/bin/bat ]; then
    wget https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
    sudo dpkg -i bat_0.18.3_amd64.deb
fi

# only DNF is here, other installations are in install.sh
"$(dirname "$0")"/install.sh
