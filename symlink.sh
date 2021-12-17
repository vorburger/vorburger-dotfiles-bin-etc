#!/usr/bin/env bash
set -euox pipefail

# See also ./symlink-homefree.sh for an equivalent which does not use $HOME

DIR="$(realpath $(dirname $0))"

# TODO avoid copy/paste between here and ./symlink.sh
f() {
  if [ ! -e ~/$1 ]
  then
    mkdir -p $(dirname ~/$1)
    ln --symbolic --relative $DIR/$2 ~/$1
  fi
}

d() {
  mkdir -p ~/$1
  find $DIR/$2 -maxdepth 1 -type f -exec ln -sfnr {} ~/$1 \;
}

# TODO auto-l all dotfiles/*

f .alias dotfiles/alias
f .bashrc dotfiles/bashrc
d .bash.d/ dotfiles/bash.d/
f .inputrc dotfiles/.inputrc
f .nanorc  dotfiles/.nanorc
f .tmux.conf dotfiles/.tmux.conf
# f .zshrc   dotfiles/.zshrc
f .gnupg/gpg.conf dotfiles/gpg.conf
f .gnupg/gpg-agent.conf dotfiles/gpg-agent.conf
f .gitconfig dotfiles/gitconfig
d .local/share/applications/ dotfiles/desktop/
d .config/kitty/ dotfiles/kitty/
f .hyper.js dotfiles/hyper.js
d .config/fish/functions/ dotfiles/fish/functions/
d .config/fish/ dotfiles/fish/
f .config/starship.toml dotfiles/starship.toml

desktop-file-validate ~/.local/share/applications/*.desktop
# desktop-file-install --dir=~/.local/share/applications/ ~/.local/share/applications/*.desktop
update-desktop-database ~/.local/share/applications

# Don't symlink entire $ZSH_CUSTOM, as that will break ~/.oh-my-zsh/.git repo upgrades;
# also must preserve default example.zsh-theme, so just trash our own symlinks, and relink:
# if [ -e ~/.oh-my-zsh/custom/themes ]
# then
#  find ~/.oh-my-zsh/custom/themes -type l -exec trash -f {} +
#  ln -s $DIR/dotfiles/oh-my-zsh/custom/themes/* ~/.oh-my-zsh/custom/themes
# fi
