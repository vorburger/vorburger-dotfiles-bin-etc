Set [global environment](https://fishshell.com/docs/current/faq.html) variables
using [`set`](https://fishshell.com/docs/current/cmds/set.html), e.g. like this:

    set -Ux EDITOR nano

This gets saved in `~/.config/fish/fish_variables` which [`symlink.sh`](../../symlink.sh) symlinks correctly
(if it doesn't already exist, otherwise `mv ~/.config/fish/fish_variables ~/dev/dotfiles/fish/fish_variables`
and `rm ~/.config/fish/fish_variables` and `./symlink.sh` to repair.

They are NOT [be host specific](https://stackoverflow.com/questions/20103968/where-are-universal-variables-stored-in-the-fish-shell)
anymore since Fish v3.
