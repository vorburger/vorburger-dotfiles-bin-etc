#!/usr/bin/env bash
set -euxo pipefail

# https://cloud.google.com/sdk/docs/install#rpm
[ -s /etc/yum.repos.d/google-cloud-sdk.repo ] || sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

# https://github.com/charmbracelet/glow#package-manager
[ -s /etc/yum.repos.d/charm.repo ] || sudo tee -a /etc/yum.repos.d/charm.repo << EOM
[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key
EOM

sudo dnf install -y \
    glow glibc-langpack-en glibc-all-langpacks \
    rpl psmisc procps-ng \
    bash-completion \
    dnf-automatic dnf-plugins-core \
    golang git htop \
    java-17-openjdk-devel java-17-openjdk-src java-17-openjdk-javadoc java-17-openjdk-javadoc-zip java-17-openjdk-jmods \
    powerline-fonts trash-cli ShellCheck tmux wipe wl-clipboard \
    fira-code-fonts mozilla-fira-mono-fonts \
    fish autojump-fish autojump fd-find bat \
    automake autoconf texinfo gettext-devel ncurses-devel \
    pwgen diceware \
    graphviz \
    helm google-cloud-sdk google-cloud-sdk-skaffold \
    python3-devel portaudio-devel \
    git-delta rclone \
    gcc gcc-c++ clang-tools-extra \
    nodejs xrandr \
    ruby-devel rubygems \
    openssl-devel
# clang-tools-extra for clang-format, gcc-c++ is used by Bazel Protobuf
# xrandr is required by Minecraft client to fix ArrayIndexOutOfBoundsException at org.lwjgl.opengl.LinuxDisplay.getAvailableDisplayModes()
# openssl-devel is used (only, so far) by https://github.com/swsnr/mdcat

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
