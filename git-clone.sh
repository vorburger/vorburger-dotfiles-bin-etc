#!/usr/bin/env bash
set -euo pipefail

# Default path for the git executable.
GIT_CMD="${GIT_CMD:-git}"
if ! command -v "$GIT_CMD" &> /dev/null; then
  echo "Error: Git command not found at '$GIT_CMD'." >&2
  echo "Please install git or provide a valid path via GIT_CMD env var." >&2
  exit 1
fi

# Clones a GitHub repository if it doesn't already exist locally, and prints the target directory path.
#   @param {string} $1 The GitHub repository, in "owner/repo" format, or a full git URL.
clone() {
  local repo="$1"
  repo="${repo#https://github.com/}"
  repo="${repo#git@github.com:}"
  repo="${repo%.git}"
  local owner="${repo%%/*}"
  local protocol

  local repo_url
  case "$owner" in
    vorburger|MariaDB4j|enola-dev)
      protocol="ssh"
      repo_url="git@github.com:$repo.git"
      ;;
    *)
      protocol="https"
      repo_url="https://github.com/$repo.git"
      ;;
  esac

  local target_dir="$HOME/git/github.com/$repo"
  if [ ! -d "$target_dir" ]; then
    echo "Cloning '$repo' into '$target_dir'..." >&2
    mkdir -p "$(dirname "$target_dir")"
    "$GIT_CMD" clone "$repo_url" "$target_dir"
    cd "$target_dir"

    if [ "$protocol" == "https" ]; then
      local repo_name="${repo##*/}"
      local fork_url="git@github.com:vorburger/$repo_name.git"
      "$GIT_CMD" remote add vorburger "$fork_url"
    fi
  else
    echo "Directory '$target_dir' already exists. Skipping." >&2
  fi
  echo "$target_dir"
}

if [ "$#" -eq 0 ]; then
    clone vorburger/vorburger-dotfiles-bin-etc
    clone scopatz/nanorc
    clone seitz/nanonix
else
    for repo in "$@"; do
        clone "$repo"
    done
fi
