#!/usr/bin/env bash
set -euxo pipefail

# *install.sh package and other software installation, this is config (non-UI only; UI is in gnome-settings.sh)

sudo dnf install -y dnf-automatic podman-docker toolbox

# also in dnf-install.sh
sudo systemctl enable --now dnf-automatic-install.timer

sudo loginctl enable-linger $USER

# also similar in container/sshd/Dockerfile
sudo systemctl enable --now sshd
sudo sh -c 'echo "PasswordAuthentication no" >>/etc/ssh/sshd_config.d/01-local.conf'
sudo sh -c 'echo "KbdInteractiveAuthentication no" >>/etc/ssh/sshd_config.d/01-local.conf'
sudo sh -c 'echo "GSSAPIAuthentication no" >>/etc/ssh/sshd_config.d/01-local.conf'
sudo systemctl restart sshd

# https://buildpacks.io/docs/app-developer-guide/building-on-podman/
systemctl enable --now --user podman.socket
