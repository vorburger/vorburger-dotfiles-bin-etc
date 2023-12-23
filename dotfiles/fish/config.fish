set DOTFILES (dirname (realpath (status --current-filename)))/../..

fish_add_path $DOTFILES/bin $HOME/bin $HOME/.local/bin (go env GOPATH)/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.npm/bin
# NOT $PWD/node_modules/.bin, see https://github.com/vorburger/Notes/blob/master/Reference/javascript.md#pnpm

# autojump.fish from https://github.com/wting/autojump/blob/master/bin/autojump.fish is installed by the autojump-fish package
test -f /usr/share/autojump/autojump.fish && source /usr/share/autojump/autojump.fish

test -f /usr/local/bin/starship && starship init fish | source

# https://github.com/sharkdp/bat#man
# NOT https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
# For alternatives, see https://wiki.archlinux.org/title/Color_output_in_console#man
test -f /usr/bin/bat && set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'" && set -Ux MANROFFOPT "-c"

# Keyboard bindings
# fish_key_reader is great to find the appropriate keyboard escape sequence! See
# https://fishshell.com/docs/current/cmds/bind.html#special-input-functions, also
# https://fishshell.com/docs/current/#escaping-characters is useful; note
# "bind" shows all current bindings, and eg. "bind \cP" shows Ctrl-P's.

# Use word instead of backward-kill-path-component to match .inputrc
bind \b backward-kill-word

# Ctrl-P for FZF, same as default Ctrl-T - for consistency with VSC
bind \cp fzf-file-widget
