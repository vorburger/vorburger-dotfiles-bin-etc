#!/usr/bin/env bash
set -euox pipefail

# TODO Flip order - it would be more logically readable if it was flipped (source to target)

# TODO Make this more quiet!

# See also ./symlink-homefree.sh for an equivalent which does not use $HOME

DIR="$(realpath $(dirname "$0"))"

# TODO avoid copy/paste between here and ./symlink-homefree.sh
f() {
  _f "soft" "$1" "$2"
}

fh() {
  _f "hard" "$1" "$2"
}

_f() {
  local mode=$1
  local target=$2
  local source=$3
  local dest="$HOME/$target"
  local src_path="$DIR/$source"

  if [[ -h "$dest" && ! -e "$dest" ]]; then
    echo "$dest is a BROKEN symlink, fixing it..." >&2
    rm "$dest"
  fi

  if [[ ! -e "$dest" ]]; then
    mkdir -p "$(dirname "$dest")"
    if [[ "$mode" == "soft" ]]; then
      ln --symbolic --relative "$src_path" "$dest"
    else
      ln "$src_path" "$dest"
    fi
  else
    # It exists. Check if it is the correct link.
    if [[ "$dest" -ef "$src_path" ]]; then
      # It is the correct link (either soft or hard), all good.
      :
    else
      # It is not the correct link.
      if [[ "${CODESPACES:-}" == "true" ]]; then
        echo "$dest already exists and is not the correct link. Backing up to $dest.bak and overwriting, because CODESPACES is set." >&2
        mv "$dest" "$dest.bak"
        if [[ "$mode" == "soft" ]]; then
          ln --symbolic --relative "$src_path" "$dest"
        else
          ln "$src_path" "$dest"
        fi
      else
        echo "$dest already exists and is not the correct link (and we're not in a Codespace)." >&2
        if [[ -L "$dest" ]]; then
          echo "  points to: $(readlink "$dest") -> $(realpath "$dest")" >&2
          echo "  should point to: $(realpath "$src_path")" >&2
        fi
        exit 1
      fi
    fi
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
f .gnupg/scdaemon.conf dotfiles/.gnupg/scdaemon.conf
f .gitconfig dotfiles/gitconfig
d .local/share/gh-triage/ dotfiles/.local/share/gh-triage/
d .local/share/applications/ dotfiles/desktop/
d .config/bat/ dotfiles/bat/
d .config/git/ dotfiles/git/
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
f .gemini/settings.json dotfiles/.gemini/settings.json
fh .gemini/policies/auto-saved.toml dotfiles/.gemini/policies/auto-saved.toml
f .gemini/GEMINI.md dotfiles/.gemini/GEMINI.md
f .gemini/antigravity/mcp_config.json dotfiles/.gemini/antigravity/mcp_config.json
f .config/Code/User/mcp.json dotfiles/code/mcp.json
f .config/Code/User/settings.json dotfiles/code/settings.json
f .config/Code/User/keybindings.json dotfiles/code/keybindings.json
f .config/Code/User/snippets/personal.code-snippets dotfiles/code/personal.code-snippets
f .config/Antigravity/User/settings.json dotfiles/code/settings.json
f .config/Antigravity/User/keybindings.json dotfiles/code/keybindings.json
f .config/Antigravity/User/snippets/personal.code-snippets dotfiles/code/personal.code-snippets
f .config/rygel.conf dotfiles/rygel.conf

# This is used by dotfiles/.gemini/GEMINI.md
ln -fs "$HOME/git/github.com/vorburger/aifiles" "$HOME/.gemini/"

if [ "$(command -v desktop-file-validate)" ]; then
  desktop-file-validate ~/.local/share/applications/*.desktop
  # desktop-file-install --dir=~/.local/share/applications/ ~/.local/share/applications/*.desktop
  update-desktop-database ~/.local/share/applications
fi
