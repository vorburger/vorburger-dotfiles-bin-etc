#!/usr/bin/env bash
set -euxo pipefail

sudo apt install -y \
    bash-completion \
    golang git hub htop \
    nano mosh trash-cli shellcheck tmux wipe \
    fish autojump fzf fd-find \
    cargo

# TODO https://github.com/wting/autojump#linux /usr/share/doc/autojump/README.Debian
# TODO https://github.com/Peltoche/lsd
# TODO https://github.com/sharkdp/bat#on-ubuntu-using-apt

# only DNF is here, other installations are in install.sh
./install.sh

