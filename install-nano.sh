#!/usr/bin/env bash
set -euxo pipefail

NANO="$HOME/git/git.savannah.gnu.org/nano"
if ! [[ -e "$NANO" ]]; then
  mkdir -p "$NANO"
  git clone git://git.savannah.gnu.org/nano.git "$NANO"
fi

cd "$NANO"
./autogen.sh
./configure
make

mkdir -p ~/bin/
ln -s "$NANO"/src/nano ~/bin/
