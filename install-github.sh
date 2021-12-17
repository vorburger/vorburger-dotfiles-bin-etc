#!/usr/bin/env bash
set -euxo pipefail

DIR="/tmp/install-github/$1/"
ZIP="$DIR/$2.zip"
SHA="$DIR/$2.zip.sha256"
rm -rf "$DIR"

mkdir -p "$DIR"
[ -s "$ZIP" ] || curl -fsSL "https://github.com/$1/releases/latest/download/$2.zip" -o "$ZIP"
[ -s "$SHA" ] || curl -fsSL "https://github.com/$1/releases/latest/download/$2.zip.sha256" -o "$SHA"
file "$ZIP"
# TODO https://github.com/apache/maven-mvnd/pull/539: sha256sum -c "$SHA" "$ZIP"

# rm -rf "$HOME/bin/$2*
unzip "$ZIP" -d "$DIR"
mv "$DIR/$2" ~/bin/
ln -s "$HOME/bin/$2/bin/$3" "$HOME/bin/$3"
