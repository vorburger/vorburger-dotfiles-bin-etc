#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get update && sudo apt-get dist-upgrade -y

# see install-nano.sh (which install.sh only invokes if there is no /usr/bin/nano)
sudo apt remove -y nano

sudo apt install -y \
    bash-completion \
    golang git hub htop \
    trash-cli shellcheck tmux wipe \
    fish autojump fzf fd-find \
    cargo \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev

# TODO https://github.com/wting/autojump#linux /usr/share/doc/autojump/README.Debian

# https://github.com/Peltoche/lsd
# TODO automatically download latest version instead of hard-coding
[ -s /usr/bin/lsd ] || \
    wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb && \
    sudo dpkg -i lsd_0.20.1_amd64.deb

# TODO https://github.com/sharkdp/bat#on-ubuntu-using-apt

# only DNF is here, other installations are in install.sh
./install.sh
