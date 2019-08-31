#!/bin/sh
# -x to print all commands as they are executed (helpful for debugging)
set -euo pipefail

DIR="$(realpath $(dirname $0))"

if [ ! -e ~/.zshrc ]
then
  ln -s $DIR/dotfiles/zshrc ~/.zshrc
fi

# Don't symlink entire $ZSH_CUSTOM, as that will break ~/.oh-my-zsh/.git repo upgrades;
# also must preserve default example.zsh-theme, so just trash our own symlinks, and relink:
# if [ -e ~/.oh-my-zsh/custom/themes ]
# then
#  find ~/.oh-my-zsh/custom/themes -type l -exec trash -f {} +
#  ln -s $DIR/dotfiles/oh-my-zsh/custom/themes/* ~/.oh-my-zsh/custom/themes
# fi
