#!/usr/bin/env bash
set -euxo pipefail

# This script installs packages from GitHub releases.
# This is NOT directly related GitHub Codespaces - that's bootstrap.sh

DIR="/tmp/install-github/$1/"
ZIP="$DIR/$3.zip"
SHA="$DIR/$3.zip.sha256"
rm -rf "$DIR"

mkdir -p "$DIR"
[ -s "$ZIP" ] || curl -fsSL "https://github.com/$1/releases/download/$2/$3.zip" -o "$ZIP"
# [ -s "$SHA" ] || curl -fsSL "https://github.com/$1/releases/download/$2/$3.zip.sha256" -o "$SHA"
file "$ZIP"
# sha256sum -c "$SHA" "$ZIP"

unzip "$ZIP" -d "$DIR"
