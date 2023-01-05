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
    glibc-langpack-en glibc-all-langpacks \
    rpl psmisc procps-ng \
    asciinema \
    bash-completion \
    dnf-automatic dnf-plugins-core \
    golang git htop \
    java-11-openjdk-devel java-11-openjdk-src java-11-openjdk-jmods \
    powerline-fonts trash-cli ShellCheck tmux wipe wl-clipboard \
    fira-code-fonts mozilla-fira-mono-fonts \
    fish autojump-fish autojump fd-find bat \
    automake autoconf texinfo gettext-devel ncurses-devel \
    pwgen diceware \
    cargo graphviz \
    google-cloud-sdk google-cloud-sdk-skaffold \
    python3-devel portaudio-devel \
    git-delta

# Do NOT add the "kubernetes-client" package above, but it causes this error:
# file /usr/bin/kubectl conflicts between attempted installs of kubernetes-client-1.21.0-2.fc35.x86_64 and kubectl-1.23.0-0.x86_64
# (at least when run as part of ./container/build.sh which is FROM fedora:35 in container/fedora-updated/Dockerfile)

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md#fedora-centos-red-hat-enterprise-linux-dnf
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# Also in setup.sh
if [ $(ps --no-headers -o comm 1) = "systemd" ]; then
  sudo systemctl enable --now dnf-automatic-install.timer
  systemctl status dnf-automatic-install.timer
else
  echo "Not enabling dnf-automatic-install.timer, because no systemd"
fi

sudo dnf update -y

sudo dnf remove -y "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk
