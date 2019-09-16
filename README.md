# Usage

    mkdir ~/dev/
    cd ~/dev/
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./dnf-install.sh
    rm ~/.bashrc
    ./symlink.sh

NB: The `~/dev/vorburger-dotfiles-bin-etc/` path is currently hard-coded e.g. in `dotfiles/bashrc`.

Edit ~/.ssh/config and list required hosts.  _(TODO test if that is actually really still needed...)_


## Manual

### GNOME

    ./gnome-settings.sh

    sudo dnf install gnome-tweak-tool

Launch `gnome-tweaks`, _Startup Applications_, `+` Terminal and Chrome/Firefox.
This puts (copies of, not symlinks to) `firefox.desktop` and `org.gnome.Terminal.desktop` into `~/.config/autostart/`.

Edit `~/.config/autostart/org.gnome.Terminal.desktop` and after `Exec=gnome-terminal` append `--full-screen` (or just `--window --maximize`).

Settings > Mouse & Touchpad : Touchpad > Natural Scrolling enabled  &&  Tap to Click.


## Containers

See [containers/](containers/).
