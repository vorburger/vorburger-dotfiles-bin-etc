#!/usr/bin/env bash
set -euxo pipefail

# apt|dnf-install.sh has DNF packages, this is everything else

[ -s /usr/bin/nano ] || [ -s $HOME/bin/nano ] || "$(dirname "$0")"/install-nano.sh

if [ ! -f /usr/local/bin/starship ]; then
  curl -fsSL https://starship.rs/install.sh -o /tmp/starship-install.sh
  chmod +x /tmp/starship-install.sh
  sudo /tmp/starship-install.sh --yes
fi

# Go NOT like this, because this assumes we have an older golang system package, which is confusing:
#   go get golang.org/dl/go1.15.8
#   eval $(go1.15.8 env GOROOT)
# https://golang.org/doc/install
if [ ! $(command -v go) ]; then
  curl -fsSL https://golang.org/dl/go1.17.5.linux-amd64.tar.gz -o /tmp/go.tgz
  sudo tar -C /usr/local -xzf /tmp/go.tgz
  sudo ln -s /usr/local/go/bin/go* /usr/local/bin/
fi
go version

# https://github.com/apache/maven-mvnd/
mkdir -p $HOME/.m2/
[ -s $HOME/bin/mvnd ] || "$(dirname "$0")"/install-github.sh apache/maven-mvnd mvnd-0.7.1-linux-amd64 mvnd
[ -s $HOME/.m2/mvnd.properties ] || echo "java.home=/etc/alternatives/java_sdk/" >$HOME/.m2/mvnd.properties

# NB alias b="bazelisk " in dotfiles/alias
[ -s $HOME/go/bin/bazelisk ] || go get github.com/bazelbuild/bazelisk

# https://github.com/mikefarah/yq#go-get
[ -s $HOME/go/bin/yq ] || go get github.com/mikefarah/yq/v4

# https://github.com/dty1er/kubecolor
[ -s $HOME/go/bin/kubecolor ] || go install github.com/dty1er/kubecolor/cmd/kubecolor@latest

# https://github.com/jez/as-tree
# cargo install core dumps (at least in Debian, at least sometimes)
# [ -s $HOME/.cargo/bin/as-tree ] || cargo install -f --git https://github.com/jez/as-tree

# https://github.com/jorgebucaran/fisher
[ -s $HOME/.config/fish/functions/fisher.fish ] || fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

# https://github.com/PatrickF1/fzf.fish
# TODO https://github.com/PatrickF1/fzf.fish/discussions/111 how to TMUX?
# TODO https://github.com/PatrickF1/fzf.fish/discussions/112 how to hide . files/dirs?
# TODO [ -s $HOME/.config/fish/functions/__fzf* ] || ...
[ -s $HOME/.config/fish/conf.d/fzf.fish ] || fish -c "fisher install PatrickF1/fzf.fish"

# https://github.com/evanlucas/fish-kubectl-completions
# TODO remove when https://github.com/kubernetes/kubectl/issues/576 is available
# see https://github.com/evanlucas/fish-kubectl-completions/issues/33
[ -s $HOME/.config/fish/completions/kubectl.fish ] || fish -c "fisher install evanlucas/fish-kubectl-completions"

# https://github.com/jorgebucaran/autopair.fish
[ -s $HOME/.config/fish/conf.d/autopair.fish ] || fish -c "fisher install jorgebucaran/autopair.fish"

# https://github.com/Gazorby/fish-abbreviation-tips
[ -s $HOME/.config/fish/conf.d/abbr_tips.fish ] || fish -c "fisher install gazorby/fish-abbreviation-tips"

fish -c "fisher update"

# ADD ALL fisher generated fish functions to .gitignore instead of committing them
