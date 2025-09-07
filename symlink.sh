#!/usr/bin/env bash
set -euox pipefail

# TODO Make this more quiet!

# See also ./symlink-homefree.sh for an equivalent which does not use $HOME

DIR="$(realpath $(dirname "$0"))"

# TODO avoid copy/paste between here and ./symlink-homefree.sh
f() {
  if [[ -h ~/$1 && ! -e ~/$1 ]]; then
    echo "~/$1 is a BROKEN symlink, so NO NEW DOTFILES CREATED (fix that first)"
  elif [[ ! -e ~/$1 ]]; then
    mkdir -p $(dirname ~/"$1")
    ln --symbolic --relative "$DIR"/"$2" ~/"$1"
  else
    # ls -l ~/$1
    echo "~/$1 ALREADY EXISTS, so NO NEW DOTFILES SYMLINK CREATED (rm it first to create)"
  fi
}

d() {
  mkdir -p ~/"$1"
  find "$DIR"/"$2" -maxdepth 1 -type f,l -exec ln -sfnr {} ~/"$1" \;
}

# If this script runs before gpg had a chance to create ~/.gnupg/ itself,
# then it will have rwxr-xr-x instead of drwx------ which will cauge gpg to print:
# gpg: WARNING: unsafe permissions on homedir '/home/vorburger/.gnupg'
# Let's fix that like this:
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg

# TODO Simplify this by moving everything to the expected place in git already...
f .flox dotfiles/.flox/
f .tool-versions dotfiles/.tool-versions
f .bashrc dotfiles/bashrc
d .bash.d/ dotfiles/bash.d/
f .bazelrc dotfiles/.bazelrc
f .inputrc dotfiles/.inputrc
f .nanorc  dotfiles/.nanorc
f .npmrc   dotfiles/.npmrc
# f .wakatime.cfg dotfiles/wakatime.cfg
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
d .config/home-manager/ dotfiles/home-manager/
d .config/nix dotfiles/nix
f .config/starship.toml dotfiles/starship.toml
f .config/sway/config dotfiles/.config/sway/config
f .config/weston.ini dotfiles/.config/weston.ini
f .config/lsd/config.yaml dotfiles/lsd.yaml
f .m2/toolchains.xml dotfiles/m2/toolchains.xml
f .config/Code/User/settings.json dotfiles/code/settings.json
f .config/Code/User/keybindings.json dotfiles/code/keybindings.json
f .config/Code/User/snippets/personal.code-snippets dotfiles/code/personal.code-snippets
f .config/rygel.conf dotfiles/rygel.conf

if [ $(command -v desktop-file-validate) ]; then
  desktop-file-validate ~/.local/share/applications/*.desktop
  # desktop-file-install --dir=~/.local/share/applications/ ~/.local/share/applications/*.desktop
  update-desktop-database ~/.local/share/applications
fi
