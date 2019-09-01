# Usage

    mkdir -p ~/dev/
    cd ~/dev/
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./dnf-install.sh
    ./symlink.sh

NB: The `~/dev/vorburger-dotfiles-bin-etc/` path is currently hard-coded e.g. in `dotfiles/bashrc`.


## Manual

### GNOME

    ./gnome-settings.sh

    sudo dnf install gnome-tweak-tool

Launch `gnome-tweaks`, _Startup Applications_, `+` Terminal and Firefox.
This puts (copies of, not symlinks to) `firefox.desktop` and `org.gnome.Terminal.desktop` into `~/.config/autostart/`.

Edit `~/.config/autostart/org.gnome.Terminal.desktop` and append `--window --maximize` after `Exec=gnome-terminal`.
