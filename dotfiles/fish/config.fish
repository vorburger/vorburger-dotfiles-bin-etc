source ~/.config/fish/alias.fish

# autojump.fish from https://github.com/wting/autojump/blob/master/bin/autojump.fish is installed by the autojump-fish package
source /usr/share/autojump/autojump.fish

starship init fish | source

# Keyboard bindings
# fish_key_reader is great to find the appropriate keyboard escape sequence!
# see https://fishshell.com/docs/current/cmds/bind.html#special-input-functions
# https://fishshell.com/docs/current/#escaping-characters is useful
# bind \b e.g. shows current binding
bind \b backward-kill-path-component
