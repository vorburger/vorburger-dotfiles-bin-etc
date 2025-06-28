#!/usr/bin/env bash
set -euxo pipefail

# TODO Replace this "imperative" NIXing with a fully "declarative" one...
#   probably (?) using https://nix-community.github.io/home-manager/,
#   if that's suitable, at least for Flake-like (instead of profile)
#   install, outside of NixOS?

nix profile install nixpkgs#nixfmt
nix profile install nixpkgs#nixd
nix profile install nixpkgs#nil
