#!/bin/sh
set -euxo pipefail

DIR="$(realpath $(dirname $0))"

# TODO make these a function instead of copy/paste
trash ~/bin/github2gerrit.sh
ln -s $DIR/bin/github2gerrit.sh ~/bin/github2gerrit.sh

if [ -e ~/.zshrc ]
then
  trash -v ~/.zshrc
fi
ln -s $DIR/.zshrc ~/.zshrc
