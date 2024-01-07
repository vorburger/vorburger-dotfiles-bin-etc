#!/usr/bin/env bash
set -euxo pipefail

if [ ! -d ~/git/github.com/scopatz/ ]; then
  git clone https://github.com/scopatz/nanorc.git ~/git/github.com/scopatz
fi

# https://github.com/tmux-plugins/tpm#installation
if [ ! -d ~/.tmux/plugins/tpm/ ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # https://github.com/tmux-plugins/tpm/blob/master/docs/automatic_tpm_installation.md
  ~/.tmux/plugins/tpm/bin/install_plugins
fi
