#!/usr/bin/env bash
set -euxo pipefail

# This sets up dotfiles in GitHub Codespaces, see
# https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles

if [ -f /etc/os-release ]; then
    cat /etc/os-release
fi

# If running as root in a container without sudo available, create a passthrough stub
if [ "$(id -u)" = "0" ] && [ -f /.dockerenv ] && ! command -v sudo &> /dev/null; then
    printf '#!/bin/sh\nexec "$@"\n' > /usr/local/bin/sudo
    chmod +x /usr/local/bin/sudo
fi

if [ -f /etc/lsb-release ] && (grep -qi "Ubuntu" /etc/lsb-release); then
    echo "You're running Ubuntu"
    cat /etc/lsb-release
    ./ubuntu-install.sh

elif [ -f /etc/debian_version ]; then
    echo "You're running Debian"
    cat /etc/debian_version
    ./debian-install.sh

# TODO Add Fedora check (and dnf-install[-gui].sh) here as well! Needs restructuring...

else
    echo "Unable to determine if you're running Debian or Ubuntu!"
fi

./symlink.sh
