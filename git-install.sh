#!/usr/bin/env bash
set -euxo pipefail

if [ ! -d ~/git/github.com/scopatz/ ]; then
  git clone https://github.com/scopatz/nanorc.git ~/git/github.com/scopatz
fi
