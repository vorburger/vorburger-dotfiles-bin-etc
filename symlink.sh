#!/usr/bin/env bash
set -euox pipefail

# See also ./symlink-homefree.sh for an equivalent which does not use $HOME

DIR="$(realpath $(dirname $0))"

# TODO avoid copy/paste between here and ./symlink-homefree.sh
f() {
  if [ ! -e ~/$1 ]
  then
    mkdir -p $(dirname ~/$1)
    ln --symbolic --relative $DIR/$2 ~/$1
  else
    ls -l ~/$1
    echo "~/$1 ALREADY EXISTS, so NO NEW DOTFILES SYMLINK CREATED (rm it first to create)"
  fi
}

d() {
  mkdir -p ~/$1
  find $DIR/$2 -maxdepth 1 -type f,l -exec ln -sfnr {} ~/$1 \;
}



f .bashrc dotfiles/bashrc
d .bash.d/ dotfiles/bash.d/
f .inputrc dotfiles/.inputrc
f .nanorc  dotfiles/.nanorc
f .tmux.conf dotfiles/.tmux.conf
f .gnupg/gpg.conf dotfiles/gpg.conf
f .gnupg/gpg-agent.conf dotfiles/gpg-agent.conf
f .gitconfig dotfiles/gitconfig
d .local/share/applications/ dotfiles/desktop/
d .config/kitty/ dotfiles/kitty/
d .config/fish/ dotfiles/fish/
d .config/fish/completions/ dotfiles/fish/completions/
d .config/fish/conf.d/ dotfiles/fish/conf.d/
d .config/fish/functions/ dotfiles/fish/functions/
f .config/starship.toml dotfiles/starship.toml
f .m2/toolchains.xml dotfiles/m2/toolchains.xml

if [ $(command -v desktop-file-validate) ]; then
  desktop-file-validate ~/.local/share/applications/*.desktop
  # desktop-file-install --dir=~/.local/share/applications/ ~/.local/share/applications/*.desktop
  update-desktop-database ~/.local/share/applications
fi
