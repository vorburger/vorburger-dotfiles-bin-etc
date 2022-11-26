#!/usr/bin/env bash
set -euxo pipefail

if [ ! -d ~/git/github.com/scopatz/ ]; then
  mkdir -p ~/git/github.com/scopatz/
  cd ~/git/github.com/scopatz/
  git clone https://github.com/scopatz/nanorc.git
fi
