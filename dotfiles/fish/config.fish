set DOTFILES (dirname (realpath (status --current-filename)))/../..

fish_add_path $DOTFILES/bin $HOME/bin $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.krew/bin

# autojump.fish from https://github.com/wting/autojump/blob/master/bin/autojump.fish is installed by the autojump-fish package
test -f /usr/share/autojump/autojump.fish && source /usr/share/autojump/autojump.fish

test -f /usr/local/bin/starship && starship init fish | source

# Keyboard bindings
# fish_key_reader is great to find the appropriate keyboard escape sequence! See
# https://fishshell.com/docs/current/cmds/bind.html#special-input-functions, also
# https://fishshell.com/docs/current/#escaping-characters is useful; note
# eg. bind \b shows current binding.

# Use word instead of backward-kill-path-component to match .inputrc
bind \b backward-kill-word
