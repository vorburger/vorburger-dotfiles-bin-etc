# Usage

    mkdir ~/dev/
    cd ~/dev/
    git clone https://github.com/scopatz/nanorc.git
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./dnf-automatic-setup
    ./dnf-install.sh
    rm ~/.bashrc
    ./symlink.sh

NB: The `~/dev/vorburger-dotfiles-bin-etc/` path is currently hard-coded e.g. in `dotfiles/bashrc`.


## `ssh` (incl. `git`) with YubiKey

As e.g. per https://github.com/drduh/YubiKey-Guide#replace-agents, we need to appropriately set
the `SSH_AUTH_SOCK` environment variable on the laptop (workstation) that we work on.  There are 2 ways
to do this:  **EITHER** we set this on (only!!) the laptop in a `~/.bash.d/` (which [our `.bashrc`](dotfiles/bashrc)
sources), so that **ALL** `ssh` and `git` invocations use this:

    echo "export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)" > ~/.bash.d/SSH_AUTH_SOCK
    chmod +x ~/.bash.d/SSH_AUTH_SOCK

    echo 'alias t="ssh -A server.domain.tld"' > ~/.bash.d/alias-t

respectively for tmux, something like (NB use of our [`tmux2`](bin/tmux2)):

    echo 'alias t="ssh -At server.domain.tld -- tmux2 new -A -s dev"' > ~/.bash.d/alias-t

**OR**, alternatively, e.g. if we use different SSH keys and/or agents, we directly set `SSH_AUTH_SOCK` only for specific SSH:

    echo 'alias t="SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket) ssh -A server.domain.tld"' > ~/.bash.d/alias-t

and to make `git` "just work" we do the following (which is better than an alias, because a script in PATH works in other scripts as well):

    echo 'SSH_AUTH_SOCK=$(/usr/bin/gpgconf --list-dirs agent-ssh-socket) /usr/bin/git "$@"' > ~/bin/git

These `gpgconf --list-dirs agent-ssh-socket` will set `SSH_AUTH_SOCK` on (only!!) the *laptop* (*workstation*)
to something like `/run/user/1000/gnupg/S.gpg-agent.ssh`.  On a (Fedora 30) *server* that we connect to, `ssh` will
correctly set `SSH_AUTH_SOCK` to something like `/tmp/ssh-mXzCzYT2Np/agent.7541` when we connect (baring [`tmux2`](bin/tmux2)).  
We therefore **CANNOT** set `SSH_AUTH_SOCK` in a [`.bashrc`](dotfiles/bashrc) which is shared on both the *laptop*
(*workstation*) **and** the *server*!  (That would break SSH Agent forwarding.)

In both of cases above, note and remember to use `ssh -A` to enable Agent Forwarding.
We could alternatively use `ForwardAgent yes` in our `~/.ssh/config`, but as a security best practice,
always *only for a SINGLE Hostname*_, never for all servers.

BTW: `RemoteForward` in `~/.ssh/config` is not actually required (at least with Fedora 30).


## Manual Settings

### GNOME

    ./gnome-settings.sh

    sudo dnf install gnome-tweak-tool

Launch `gnome-tweaks`, _Startup Applications_, `+` Terminal and Chrome/Firefox.
This puts (copies of, not symlinks to) `firefox.desktop` and `org.gnome.Terminal.desktop` into `~/.config/autostart/`.

Edit `~/.config/autostart/org.gnome.Terminal.desktop` and after `Exec=gnome-terminal` append `--full-screen` (or just `--window --maximize`).

Settings > Mouse & Touchpad : Touchpad > Natural Scrolling enabled  &&  Tap to Click.

Settings > Keyboard Shortcuts: Delete (Backspace) Alt-ESC to Switch Windows Directly
(because we use that in TMUX).


### Power Saving

    sudo dnf install -y powertop
    sudo systemctl enable --now powertop.service
    sudo powertop  # make all Tunables (Tab) “Bad” to “Good” (Enter) ...
    sudo powertop --calibrate

    sudo dnf install -y kernel-tools
    cpupower frequency-info --governors   # powersave performance  <== see below...
    sudo cpupower frequency-info
    sudo cpupower frequency-set --governor powersave
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

**TODO** Test if the additional governors (conservative userspace powersave ondemand performance schedutil)
which should appear after _booting with the kernel parameter `intel_pstate=disable`_ help with increased battery life..


## Containers

Using https://github.com/vorburger/cloudshell for a customized web shell on http://localhost:8080 :

    podman build -t vorburger-cloud -f Dockerfile-cloudshell .
    podman run --hostname=cloud -eUSER_ID=vorburger -eUSER_PWD=THEPWD --rm -p 8080:8080 vorburger-cloud

Also (previous generation, older) see [container/](container/), but in short:

    ./container/build.sh
    docker run -d -p 2222:22 --name vorburger vorburger
    ssh -At -p 2222 localhost -- tmux2 new -A -s dev
