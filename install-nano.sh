#!/usr/bin/env bash
set -euxo pipefail

if ! [[ -z "${CODESPACES:-}" ]]; then
  echo "Skipping nano installation in GitHub Codespace set-up"
  exit
fi

NANO="$HOME/git/git.savannah.gnu.org/nano"
if ! [[ -e "$NANO" ]]; then
  mkdir -p "$NANO"
  git clone git://git.savannah.gnu.org/nano.git "$NANO"
else
  cd $NANO
  git pull
fi

cd "$NANO"
./autogen.sh
./configure
make

mkdir -p ~/bin/
# cp instead of ln -s so that we have the latest in ~/bin in the container image even if ~/git is a volume with an older one
cp "$NANO"/src/nano ~/bin/
