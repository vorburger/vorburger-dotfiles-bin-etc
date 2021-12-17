# In 'homefree' containers the aliases are in /etc/fish/ instead of $HOME
test -f ~/.alias && source ~/.alias
test -f ~/.config/fish/alias.fish && source ~/.config/fish/alias.fish

fish_add_path $HOME/bin $HOME/dev/vorburger-dotfiles-bin-etc/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.krew/bin

# TODO only if $JAVA_HOME is not already set?
set -xg JAVA_HOME /etc/alternatives/java_sdk/

# autojump.fish from https://github.com/wting/autojump/blob/master/bin/autojump.fish is installed by the autojump-fish package
test -f /usr/share/autojump/autojump.fish && source /usr/share/autojump/autojump.fish

test -f /usr/local/bin/starship && starship init fish | source

# Keyboard bindings
# fish_key_reader is great to find the appropriate keyboard escape sequence!
# see https://fishshell.com/docs/current/cmds/bind.html#special-input-functions
# https://fishshell.com/docs/current/#escaping-characters is useful
# bind \b e.g. shows current binding
bind \b backward-kill-path-component
