#!/usr/bin/env bash
set -euxo pipefail

# *install.sh package and other software installation, this is config (non-UI only; UI is in gnome-settings.sh)

if [ -e /usr/bin/dnf ]; then
    sudo dnf install -y dnf-automatic podman-docker toolbox

    # also in dnf-install.sh
    sudo systemctl enable --now dnf-automatic-install.timer

    sudo loginctl enable-linger $USER
fi

# also used in container/sshd/Dockerfile
sudo cp container/sshd/01-local.conf /etc/ssh/sshd_config.d/
sudo systemctl enable --now sshd
sudo systemctl restart sshd

# see docs/yubikey.md
systemctl --user enable --now gpg-agent-ssh.socket

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
systemctl enable --now --user podman.socket
