# These aliases are Bash specific (not shared with Fish)
# Common ones are in dotfiles/alias (fish specific in dotfiles/fish/alias.fish)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[ -s /usr/bin/lsd ] && alias l="lsd "
[ -s /usr/bin/bat ] && alias c="bat "

# https://stackoverflow.com/a/24665529/421602
source /usr/share/bash-completion/completions/git
__git_complete gl  _git_log
__git_complete gll _git_log
__git_complete glg _git_log
__git_complete gd  _git_diff
__git_complete ga  _git_add
__git_complete gco _git_checkout
__git_complete gpu _git_push
__git_complete gpl _git_pull

if hash kubectl 2>/dev/null; then
  source <(kubectl completion bash)
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# https://github.com/cykerway/complete-alias
source $DIR/cykerway_complete-alias
complete -F _complete_alias k

# Rust Cargo
export PATH="${HOME}/.cargo/bin:$PATH"

# Go built binaries
# This isn't the `go` binary itself; that's added to the PATH in go-path.sh
export PATH="${HOME}/go/bin:$PATH"
