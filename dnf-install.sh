#!/usr/bin/env bash
set -euxo pipefail

# https://cloud.google.com/sdk/docs/install#rpm
[ -s /etc/yum.repos.d/google-cloud-sdk.repo ] || sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

sudo dnf install -y \
    psmisc procps-ng \
    asciinema \
    bash-completion \
    dnf-automatic dnf-plugins-core \
    golang git hub htop \
    java-1.8.0-openjdk-devel java-1.8.0-openjdk-src \
    java-11-openjdk-devel java-11-openjdk-src java-11-openjdk-jmods \
    powerline-fonts trash-cli ShellCheck tmux wipe wl-clipboard \
    fira-code-fonts mozilla-fira-mono-fonts \
    lsd fish autojump-fish autojump fzf fd-find bat \
    automake autoconf texinfo gettext-devel ncurses-devel \
    pwgen diceware \
    cargo \
    google-cloud-sdk google-cloud-sdk-skaffold

# Do NOT add the "kubernetes-client" package above, but it causes this error:
# file /usr/bin/kubectl conflicts between attempted installs of kubernetes-client-1.21.0-2.fc35.x86_64 and kubectl-1.23.0-0.x86_64
# (at least when run as part of ./container/build.sh which is FROM fedora:35 in container/fedora-updated/Dockerfile)

if [ $(ps --no-headers -o comm 1) = "systemd" ]; then
  sudo systemctl enable --now dnf-automatic-install.timer
  systemctl status dnf-automatic-install.timer
else
  echo "Not enabling dnf-automatic-install.timer, because no systemd"
fi

sudo dnf update -y

sudo dnf remove "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
