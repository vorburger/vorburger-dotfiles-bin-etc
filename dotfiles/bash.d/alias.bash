# These aliases are Bash specific (not shared with Fish)
# Common ones are in dotfiles/alias (fish specific in dotfiles/fish/alias.fish)

[ -s /usr/bin/lsd ] && alias l="lsd "

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
