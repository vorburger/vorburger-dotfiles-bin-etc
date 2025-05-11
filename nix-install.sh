#!/usr/bin/env bash
set -euxo pipefail

# TODO Replace this "imperative" NIXing with a fully "declarative" one...

nix profile install nixpkgs#nixfmt
nix profile install nixpkgs#nixd
nix profile install nixpkgs#nil
