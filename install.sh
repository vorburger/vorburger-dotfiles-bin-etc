#!/usr/bin/env bash
set -euxo pipefail

# dnf-install.sh has DNF packages, this is everything else

[ -s /usr/local/bin/starship ] || curl -fsSL https://starship.rs/install.sh | bash

# https://github.com/mikefarah/yq#go-get
GO111MODULE=on go get github.com/mikefarah/yq/v4

# https://github.com/jez/as-tree
cargo install -f --git https://github.com/jez/as-tree


# https://github.com/jorgebucaran/fisher
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

# https://github.com/PatrickF1/fzf.fish
# TODO https://github.com/PatrickF1/fzf.fish/discussions/111 how to TMUX?
# TODO https://github.com/PatrickF1/fzf.fish/discussions/112 how to hide . files/dirs?
fish -c "fisher install PatrickF1/fzf.fish"

# https://github.com/evanlucas/fish-kubectl-completions
# TODO remove when https://github.com/kubernetes/kubectl/issues/576 is available
# see https://github.com/evanlucas/fish-kubectl-completions/issues/33
fish -c "fisher install evanlucas/fish-kubectl-completions"

# https://github.com/jorgebucaran/autopair.fish
fish -c "fisher install jorgebucaran/autopair.fish"

# https://github.com/Gazorby/fish-abbreviation-tips
fish -c "fisher install gazorby/fish-abbreviation-tips"

fish -c "fisher update"

# ADD ALL fisher generated fish functions to .gitignore instead of committing them
