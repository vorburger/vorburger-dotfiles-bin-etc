#!/usr/bin/env bash
set -euo pipefail

# TODO Rename git-install.sh (and all references to it) to git-clone.sh

# Default path for the git executable.
# This can be overridden by providing a path as the first command-line argument.
GIT_CMD="${1:-git}"
if ! command -v "$GIT_CMD" &> /dev/null; then
  echo "Error: Git command not found at '$GIT_CMD'." >&2
  echo "Please install git or provide a valid path as the first argument." >&2
  exit 1
fi

# Clones a GitHub repository if it doesn't already exist locally.
#   @param {string} $1 The GitHub repository, in "owner/repo" format.
clone() {
  local protocol="$1"
  local repo="$2"
  local target_dir="$HOME/git/github.com/$repo"

  local repo_url
  if [ "$protocol" == "ssh" ]; then
    repo_url="git@github.com:$repo.git"
  else
    repo_url="https://github.com/$repo.git"
  fi

  if [ ! -d "$target_dir" ]; then
    echo "Cloning '$repo' into '$target_dir'..."
    mkdir -p "$(dirname "$target_dir")"
    "$GIT_CMD" clone "$repo_url" "$target_dir"
  else
    echo "Directory '$target_dir' already exists. Skipping."
  fi
}

clone ssh vorburger/vorburger-dotfiles-bin-etc
clone https scopatz/nanorc
clone https seitz/nanonix
