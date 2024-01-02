#!/usr/bin/env bash
set -eoux pipefail

# This installs the Visual Studio Code (VSC) Server Tunnel as a Service;
# dnf-install-gui.sh installs the VSC "Client" UI.

# https://code.visualstudio.com/Download
# https://code.visualstudio.com/docs/?dv=linux64cli
curl -fsSL -o code-cli.tgz "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64"
tar xvf code-cli.tgz
rm code-cli.tgz
mkdir -v "$HOME"/.local/bin
mv code  "$HOME"/.local/bin/code-cli

# https://code.visualstudio.com/docs/editor/command-line#_create-remote-tunnel
"$HOME"/.local/bin/code-cli tunnel service install --accept-server-license-terms

# "Service successfully installed!"
# "You can use `code-cli tunnel service log` to monitor it, and `code-cli tunnel service uninstall` to remove it."

# systemctl --user status code-tunnel
