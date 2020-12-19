#!/usr/bin/env bash
# -x to print all commands as they are executed (helpful for debugging)
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

mkdir -p ~/.bash.d/

# TODO auto-l all dotfiles/*
l .alias dotfiles/alias
l .bashrc dotfiles/bashrc
x .bash.d/ dotfiles/bash.d/
l .inputrc dotfiles/.inputrc
l .nanorc  dotfiles/.nanorc
l .tmux.conf dotfiles/.tmux.conf
# l .zshrc   dotfiles/.zshrc
l .gnupg/gpg.conf dotfiles/gpg.conf
l .gnupg/gpg-agent.conf dotfiles/gpg-agent.conf
l .gitconfig dotfiles/gitconfig
x .local/share/applications/ dotfiles/desktop/
x .config/kitty/ dotfiles/kitty/
l .hyper.js dotfiles/hyper.js
# x .config/fish/functions/ dotfiles/fish/functions/
x .config/fish/ dotfiles/fish/
l .config/starship.toml dotfiles/starship.toml

# Don't symlink entire $ZSH_CUSTOM, as that will break ~/.oh-my-zsh/.git repo upgrades;
# also must preserve default example.zsh-theme, so just trash our own symlinks, and relink:
# if [ -e ~/.oh-my-zsh/custom/themes ]
# then
#  find ~/.oh-my-zsh/custom/themes -type l -exec trash -f {} +
#  ln -s $DIR/dotfiles/oh-my-zsh/custom/themes/* ~/.oh-my-zsh/custom/themes
# fi
