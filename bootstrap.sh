#!/usr/bin/env bash
set -euxo pipefail

# This sets up dotfiles in GitHub Codespaces, see
# https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles

if [ -f /etc/debian_version ]; then
    echo "You're running Debian"
    cat /etc/debian_version
    ./debian-install.sh

elif [ -f /etc/lsb-release ]; then
    if grep -qi "Ubuntu" /etc/lsb-release; then
        echo "You're running Ubuntu"
        cat /etc/lsb-release

        ./ubuntu-install.sh
        
    else
        echo "You're running another Linux distribution"
    fi

else
    echo "Unable to determine if you're running Debian or Ubuntu"
fi

./symlink.sh
