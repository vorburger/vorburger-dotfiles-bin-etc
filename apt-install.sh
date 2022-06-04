#!/usr/bin/env bash
set -euxo pipefail

# This is for anything that's common to Ubuntu and Debian; see debian|ubuntu-install.sh for Debian respectively Ubuntu specific stuff.

sudo apt --allow-releaseinfo-change update
# sudo apt-get clean && sudo apt-get update && sudo apt-get dist-upgrade -y
# sudo apt-get update --fix-missing && sudo apt-get clean && sudo apt-get clean && sudo apt-get install -f && sudo apt-get dist-upgrade -y && sudo apt autoremove -y
## dist-upgrade causes these problems on the Debian 10 (Buster)-based gcr.io/cloudshell-images/cloudshell:latest
## E: Failed to fetch https://packages.sury.org/php/pool/main/p/pcre2/libpcre2-32-0_10.36-2+0~20210212.6+debian10~1.gbp6138a4_amd64.deb  404  Not Found [IP: 104.21.18.148 443]
## E: Failed to fetch http://deb.debian.org/debian/pool/main/libw/libwebp/libwebpmux3_0.6.1-2_amd64.deb  404  Not Found [IP: 199.232.126.132 80]
## E: Failed to fetch http://deb.debian.org/debian/pool/main/h/http-parser/libhttp-parser2.8_2.8.1-1_amd64.deb  404  Not Found [IP: 199.232.126.132 80]

# NB: Do *NOT* apt install tmux, because that upgrades the version that comes with gcr.io/cloudshell-images/cloudshell:latest
# which breaks the gcr.io/cloudshell-images/custom-image-validation:latest test_ssh (__main__.CloudDevshellTests)

sudo apt install -y \
    bash-completion file git hub htop lsb-release procps unzip \
    trash-cli shellcheck wipe \
    fish autojump fd-find \
    cargo curl wget \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev

# see install-nano.sh (which all-install.sh only invokes if there is no /usr/bin/nano)
sudo apt remove -y nano
sudo apt autoremove -y

lsb_release -a

# NOT golang, as it's too old on Debian Stable; better always grab a fixed version from golang.org in all-install.sh

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

# only DNF is here, other installations are in all-install.sh
"$(dirname "$0")"/all-install.sh
