#!/usr/bin/env bash
set -euxo pipefail

# Keep this in sync with ./symlink.sh

DIR="$(realpath $(dirname $0))"

# TODO avoid copy/paste between here and ./symlink-homefree.sh
f() {
  if [ ! -e $1 ]
  then
    mkdir -p $(dirname $1)
    ln --symbolic --relative $DIR/$2 $1
  else
    ls -l $1
    echo "$1 ALREADY EXISTS, so NO NEW DOTFILES SYMLINK CREATED (rm it first to create)"
  fi
}

d() {
  mkdir -p $1
  find $DIR/$2 -maxdepth 1 -type f,l -exec ln -sfnr {} $1 \;
}

cp -R /etc/fish /etc/fish.original

# f .bashrc dotfiles/bashrc
# d .bash.d/ dotfiles/bash.d/
# f .inputrc dotfiles/.inputrc
f /usr/local/etc/nanorc  dotfiles/.nanorc
# f .tmux.conf dotfiles/.tmux.conf
# f .zshrc   dotfiles/.zshrc
# f .gnupg/gpg.conf dotfiles/gpg.conf
# f .gnupg/gpg-agent.conf dotfiles/gpg-agent.conf
f /etc/gitconfig dotfiles/gitconfig
# d .local/share/applications/ dotfiles/desktop/
# d .config/kitty/ dotfiles/kitty/
# f .hyper.js dotfiles/hyper.js
d /etc/fish/ dotfiles/fish/
d /etc/fish/conf.d/ dotfiles/fish/conf.d/
d /etc/fish/functions/ dotfiles/fish/functions/
f /etc/starship.toml dotfiles/starship.toml
# This ^^^ only works because `STARSHIP_CONFIG` is set to use it in fish/conf.d/starship.fish

# This ^^^ sets up the "homefree" config for containers with dotfiles in / instead of /home
# so that it works for all and any users and with an empty host-mounted $HOME.
# This is useful e.g. in Toolbox and Google Cloud Shell and similar.

# NOT WORKING: cp "$(dirname "$0")"/etc/profile.d/PATH_HOME-bin.sh /etc/profile.d/

cat "$DIR/dotfiles/.inputrc" >>/etc/inputrc
