#!/usr/bin/env bash

DIR=$(dirname $(realpath "${BASH_SOURCE[0]}"))
DOTFILES_BIN=$(realpath "$DIR/../../bin")

if ! [[ "$PATH" =~ "$DOTFILES_BIN" ]]
then
  PATH="$DOTFILES_BIN:$PATH"
fi
export PATH
