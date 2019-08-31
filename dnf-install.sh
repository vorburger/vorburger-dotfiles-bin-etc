#!/bin/sh
set -euxo pipefail

# Install desktop UI stuff;
# aim to containerize everything else.

sudo dnf install -y golang-bin \
	java-1.8.0-openjdk-devel java-1.8.0-openjdk-src \
	java-11-openjdk-devel java-11-openjdk-src \
	nano powerline-fonts trash-cli wipe

sudo dnf remove "libreoffice*"

# sudo alternatives --config java
# sudo alternatives --config javac
# sudo alternatives --config java_sdk_openjdk