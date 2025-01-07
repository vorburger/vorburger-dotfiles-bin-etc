#!/usr/bin/env bash
set -euxo pipefail

# *install.sh package and other software installation, this is config (non-UI only; UI is in gnome-settings.sh)

if [ -e /usr/bin/dnf5 ]; then
    sudo dnf install -y dnf5-plugin-automatic podman-docker toolbox

    # also in dnf-install.sh
    sudo systemctl enable --now dnf5-automatic.timer

    sudo echo '[commands]
apply_updates = yes
' | sudo tee -a /etc/dnf/automatic.conf

else
    echo "Not enabling dnf5-automatic.timer, because no /usr/bin/dnf5"
fi

sudo loginctl enable-linger $USER

# also used in container/sshd/Dockerfile
sudo cp container/sshd/01-local.conf /etc/ssh/sshd_config.d/
sudo systemctl enable --now sshd
sudo systemctl restart sshd

# see docs/yubikey.md
# NO systemctl --user enable --now gpg-agent-ssh.socket
systemctl disable --now --user gpg-agent.socket gpg-agent-ssh.socket

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
systemctl enable --now --user podman.socket
