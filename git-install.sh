#!/usr/bin/env bash
set -euo pipefail

# TODO Rename git-install.sh (and all references to it) to git-clone.sh

# Clones a GitHub repository if it doesn't already exist locally.
#   @param {string} $1 The GitHub repository, in "owner/repo" format.
clone() {
  local repo="$1"
  local target_dir="$HOME/git/github.com/$repo"
  local repo_url="https://github.com/$repo.git"

  if [ ! -d "$target_dir" ]; then
    echo "Cloning '$repo' into '$target_dir'..."
    mkdir -p "$(dirname "$target_dir")"
    git clone "$repo_url" "$target_dir"
  else
    echo "Directory '$target_dir' already exists. Skipping."
  fi
}

clone vorburger/vorburger-dotfiles-bin-etc
clone scopatz/nanorc
