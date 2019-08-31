#!/bin/sh
set -euxo pipefail

DIR="$(realpath $(dirname $0))"

if [ -e ~/.zshrc ]
then
  trash -v ~/.zshrc
fi
ln -s $DIR/dotfiles/zshrc ~/.zshrc

# Don't symlink entire $ZSH_CUSTOM, as that will break ~/.oh-my-zsh/.git repo upgrades;
# also must preserve default example.zsh-theme, so just trash our own symlinks, and relink:
if [ -e ~/.oh-my-zsh/custom/themes ]
then
  find ~/.oh-my-zsh/custom/themes -type l -exec trash -f {} +
  ln -s $DIR/.oh-my-zsh/custom/themes/* ~/.oh-my-zsh/custom/themes
fi
