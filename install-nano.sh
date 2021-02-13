#!/usr/bin/env bash
set -euxo pipefail

if ! [[ -e ../nano.git ]]; then
  git clone git://git.savannah.gnu.org/nano.git ../nano.git
fi

cd ../nano.git
./autogen.sh
./configure
make

make -p ~/bin/
ln -s ~/dev/nano.git/src/nano ~/bin/
