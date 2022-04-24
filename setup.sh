#!/usr/bin/env bash
set -euxo pipefail

# *install.sh package and other software installation, this is config (non-UI only; UI is in gnome-settings.sh)

sudo sh -c 'echo "PasswordAuthentication no" >/etc/ssh/sshd_config.d/99-nopwd.conf'
sudo systemctl restart sshd

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
systemctl enable --now --user podman.socket
