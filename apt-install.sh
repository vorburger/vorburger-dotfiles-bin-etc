#!/usr/bin/env bash
set -euxo pipefail

# This is for anything that's common to Ubuntu and Debian; see debian|ubuntu-install.sh for Debian respectively Ubuntu specific stuff.

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
# gh is on Debian, but behind officially repo; e.g. on 2023-01-03 it was 2.17.0 whereas latest was 2.21.1.
# Adding this repo here must be done before the "apt update" and then the "apt install gh" that comes next.
#if [ ! -f /usr/share/keyrings/githubcli-archive-keyring.gpg ]; then
#    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
#      && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
#      && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
#fi

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
    bash-completion file git gh htop lsb-release procps rpl unzip \
    trash-cli shellcheck wipe \
    autojump fd-find \
    cargo curl graphviz wget \
    autoconf automake autopoint gcc gettext groff make pkg-config texinfo libncurses-dev \
    python3-venv

# see install-nano.sh (which all-install.sh only invokes if there is no /usr/bin/nano)
sudo apt remove -y nano
sudo apt autoremove -y

lsb_release -a

# NOT golang, as it's too old on Debian Stable; better always grab a fixed version from golang.org in all-install.sh

# TODO https://github.com/wting/autojump#linux /usr/share/doc/autojump/README.Debian

# https://github.com/Peltoche/lsd
# TODO automatically download latest version instead of hard-coding
if [ ! -f /usr/bin/lsd ]; then
    wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
    sudo dpkg -i lsd_0.23.1_amd64.deb
fi

# https://github.com/sharkdp/bat
# TODO automatically download latest version instead of hard-coding
if [ ! -f /usr/bin/bat ]; then
    wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb
    sudo dpkg -i bat_0.22.1_amd64.deb
fi

# https://github.com/Peltoche/lsd
# TODO automatically download latest version instead of hard-coding
if [ ! -f /usr/bin/delta ]; then
    wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta_0.15.1_amd64.deb
    sudo dpkg -i git-delta_0.15.1_amd64.deb
fi

# only DNF is here, other installations are in all-install.sh
"$(dirname "$0")"/all-install.sh
