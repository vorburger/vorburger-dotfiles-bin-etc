#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt install -y \
    bash-completion \
    golang git hub htop \
    trash-cli shellcheck tmux wipe \
    fish autojump fzf fd-find \
    cargo \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev

# TODO https://github.com/wting/autojump#linux /usr/share/doc/autojump/README.Debian
# TODO https://github.com/Peltoche/lsd
# TODO https://github.com/sharkdp/bat#on-ubuntu-using-apt

# only DNF is here, other installations are in install.sh
./install.sh

