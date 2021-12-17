Set [global environment](https://fishshell.com/docs/current/faq.html) variables
using [`set`](https://fishshell.com/docs/current/cmds/set.html) in a `conf.d/*.fish`, e.g. like this:

    set -Ux EDITOR nano

This gets saved in `~/.config/fish/fish_variables` which WE DO NOT keep [`symlink.sh`](../../symlink.sh)
and commit to git - because it contains absolute paths which are different among my environments.
(But they are NOT [host specific](https://stackoverflow.com/questions/20103968/where-are-universal-variables-stored-in-the-fish-shell)
anymore since Fish v3.)
To migrate existing installations, just `rm ~/.config/fish/fish_variables`.
