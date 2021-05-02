#!/usr/bin/env bash
set -euox pipefail

DIR="$(realpath $(dirname $0))"

l() {
  if [ ! -e ~/$1 ]
  then
    mkdir -p $(dirname ~/$1)
    ln --symbolic --relative $DIR/$2 ~/$1
  fi
}

x() {
  mkdir -p ~/$1
  find $DIR/$2* -exec ln -sfnr {} ~/$1 \;
}

l .alias dotfiles/alias
# l .bashrc dotfiles/bashrc
# x .bash.d/ dotfiles/bash.d/
l .inputrc dotfiles/.inputrc
l .tmux.conf dotfiles/.tmux.conf
## x .config/fish/functions/ dotfiles/fish/functions/
x .config/fish/ dotfiles/fish/
# l .config/starship.toml dotfiles/starship.toml
