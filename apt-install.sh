#!/usr/bin/env bash
set -euxo pipefail

# https://fishshell.com =>
# https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
# (because Debian 11 packages an ancient Fish v3.1.2 which is 1.5 years behind)
sudo install -y curl gpg
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null

# see install-nano.sh (which install.sh only invokes if there is no /usr/bin/nano)
sudo apt remove -y nano

sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt install -y \
    bash-completion file git hub htop lsb-release procps unzip \
    trash-cli shellcheck tmux wipe \
    fish autojump fzf fd-find \
    cargo curl wget \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev

sudo apt autoremove -y

lsb_release -a

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
