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

# Don't symlink entire $ZSH_CUSTOM, as that will break ~/.oh-my-zsh/.git repo upgrades;
# also must preserve default example.zsh-theme, so just trash our own symlinks, and relink:
find ~/.oh-my-zsh/custom/themes -type l -exec trash -f {} +
ln -s $DIR/.oh-my-zsh/custom/themes/* ~/.oh-my-zsh/custom/themes
