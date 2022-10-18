#!/usr/bin/env bash
set -euxo pipefail

# apt|dnf-install.sh has DNF RPM / APT DEB packages, this is everything else

[ -s /usr/bin/nano ] || [ -s $HOME/bin/nano ] || "$(dirname "$0")"/install-nano.sh

# https://github.com/jorgebucaran/fisher, with </dev/null
# see https://github.com/jorgebucaran/fisher/issues/742
# and https://github.com/vorburger/dotfiles-reproduce-problem
[ -s $HOME/.config/fish/functions/fisher.fish ] || \
  curl -sL https://git.io/fisher -o /tmp/fisher && \
  fish -c "source /tmp/fisher && fisher install jorgebucaran/fisher </dev/null"

# https://starship.rs
if [ ! -f /usr/local/bin/starship ]; then
  curl -fsSL https://starship.rs/install.sh -o /tmp/starship-install.sh
  chmod +x /tmp/starship-install.sh
  sudo /tmp/starship-install.sh --yes
fi

# https://github.com/junegunn/fzf#using-git
if [ ! $(command -v fzf) ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
~/.fzf/bin/fzf --version

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
# TODO Fix broken installation on GitHub Codespaces (but I currently don't use it anyway)
# mkdir -p $HOME/.m2/ $HOME/bin/
# [ -s $HOME/bin/mvnd ] || "$(dirname "$0")"/install-github.sh apache/maven-mvnd 0.8.0 maven-mvnd-0.8.0-linux-amd64 mvnd && \
#   mv /tmp/install-github/apache/maven-mvnd/mvnd-0.8.0-linux-amd64 $HOME/bin/ && \
#   ln -s $HOME/bin/mvnd-0.8.0-linux-amd64/bin/mvnd $HOME/bin
# [ -s $HOME/.m2/mvnd.properties ] || echo "java.home=/etc/alternatives/java_sdk/" >$HOME/.m2/mvnd.properties

# GO_BIN_PATH may not match GOPATH (it could be unset)
GO_BIN_PATH=$(go env GOPATH)/bin

# NB alias b="bazelisk " in dotfiles/alias
[ -s $GO_BIN_PATH/bazelisk ] || go install github.com/bazelbuild/bazelisk@latest

# https://github.com/bazelbuild/buildtools/tree/master/buildifier
[ -s $GO_BIN_PATH/buildifier ] || go install github.com/bazelbuild/buildtools/buildifier@latest

# https://github.com/mikefarah/yq#go-get
[ -s $GO_BIN_PATH/yq ] || go install github.com/mikefarah/yq/v4@latest

# https://github.com/dty1er/kubecolor
[ -s $GO_BIN_PATH/kubecolor ] || go install github.com/dty1er/kubecolor/cmd/kubecolor@latest

# https://github.com/jez/as-tree
# cargo install core dumps (at least in Debian, at least sometimes)
# [ -s $HOME/.cargo/bin/as-tree ] || cargo install -f --git https://github.com/jez/as-tree

# https://github.com/PatrickF1/fzf.fish
# TODO https://github.com/PatrickF1/fzf.fish/discussions/111 how to TMUX?
# TODO https://github.com/PatrickF1/fzf.fish/discussions/112 how to hide . files/dirs?
# TODO [ -s $HOME/.config/fish/functions/__fzf* ] || ...
[ -s $HOME/.config/fish/conf.d/fzf.fish ] || fish -c "fisher install PatrickF1/fzf.fish </dev/null"

# https://github.com/evanlucas/fish-kubectl-completions
# TODO remove when https://github.com/kubernetes/kubectl/issues/576 is available
# see https://github.com/evanlucas/fish-kubectl-completions/issues/33
[ -s $HOME/.config/fish/completions/kubectl.fish ] || fish -c "fisher install evanlucas/fish-kubectl-completions </dev/null"

# https://github.com/jorgebucaran/autopair.fish
[ -s $HOME/.config/fish/conf.d/autopair.fish ] || fish -c "fisher install jorgebucaran/autopair.fish </dev/null"

# https://github.com/Gazorby/fish-abbreviation-tips
[ -s $HOME/.config/fish/conf.d/abbr_tips.fish ] || fish -c "fisher install gazorby/fish-abbreviation-tips </dev/null"

fish -c "fisher update"

# ADD ALL fisher generated fish functions to .gitignore instead of committing them
