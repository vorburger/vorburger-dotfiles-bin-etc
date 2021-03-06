# Usage

    mkdir ~/dev/
    cd ~/dev/
    git clone https://github.com/scopatz/nanorc.git
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./dnf-automatic-setup
    ./dnf-install.sh
    mv ~/.bashrc ~/.bashrc.original
    ./symlink.sh

NB: The `~/dev/vorburger-dotfiles-bin-etc/` path is currently hard-coded e.g. in `dotfiles/bashrc`.

## `ssh` Agent 101 Intro

    $ ssh git@github.com
    Enter passphrase for key '/home/vorburger/.ssh/id_ed25519': 
    $ ssh git@github.com
    Enter passphrase for key '/home/vorburger/.ssh/id_ed25519': 
    $ ssh-add -l
    Could not open a connection to your authentication agent.
    # Simply means that there is no SSH_AUTH_SOCK environment variable
    $ eval $(ssh-agent)
    Agent pid 1234
    $ echo $SSH_AUTH_SOCK 
    /tmp/ssh-AqnT5yXiLt1X/agent.1234
    $ ssh-add -l
    The agent has no identities.
    $ ssh-add .ssh/id_ed25519
    Enter passphrase for .ssh/id_ed25519: 
    $ ssh-add -l
    256 SHA256: ...
    $ ssh git@github.com
    # does not ask for passphrase anymore!

## `ssh` (incl. `git`) Agent incl. Forwarding with YubiKey

As e.g. per https://github.com/drduh/YubiKey-Guide#replace-agents, we need to appropriately set
the `SSH_AUTH_SOCK` environment variable.  You could be tempted to do something like the following:

    echo "export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)" > ~/.bash.d/SSH_AUTH_SOCK

Doing this on a sever is not required, but doing this on a workstation prevents remote SSH login to the workstation.
Instead, the [`bin/tmux*`](bin/) scripts very nicely automate and correctly integrate this with TMUX:

    [you@desktop ~]$ tmux-local new -A -X -s MAKEx

    [you@laptop ~]$ ssh -At desktop -- tmux-ssh new -A -X -s MAKEx

You probably want to put the desktop command into a launch command for your Terminal,
and `echo` the laptop command into an `~/.bash.d/alias-h`.

Remember to always use `ssh -A` to enable Agent Forwarding, as above.
We could alternatively use `ForwardAgent yes` in our `~/.ssh/config`, but as a security best practice,
always *only for a SINGLE Hostname*_, never for all servers.

BTW: `RemoteForward` in `~/.ssh/config` is not actually required (at least with Fedora 30).


## `gpg` Agent Forwarding

_TODO make it possible to use the "local" `gpg` (e.g. for `pass` et al.) when SSH'ing remotely._


## Manual Settings

### Fonts

From https://www.nerdfonts.com/font-downloads (based on https://github.com/ryanoasis/nerd-fonts),
download https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip (or later)
and unzip and double-click on _Fira Code Retina Nerd Font Complete.otf_

    lsd

    wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/bin/scripts/lib/i_linux.sh -P ~/.local/share/fonts/
    source ~/.local/share/fonts/i_linux.sh
    echo $i_linux_fedora


### Terminals

From https://github.com/tonsky/FiraCode#terminal-support :

* [Kitty](https://sw.kovidgoyal.net/kitty) (at [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty) on GitHub) is nicely minimalistic, no Settings UI.  It duplicates `tmux`, but never mind.  Very actively maintained, Fedora package à jour.
* [Hyper](https://hyper.is) looks interesting too, but more "bloated". Has RPM, but not Fedora packaged. [Font ligatures don't work in v3](https://github.com/vercel/hyper/issues/3607).
* [QTerminal](https://github.com/lxqt/qterminal) does not list `Fira Code` in File > Settings > Font, so nope.
* [Konsole](https://konsole.kde.org) drags KDE along, so no thanks.

https://github.com/topics/terminal-emulators has moar... ;-)


### Eclipse

Preferences > General > Appearance > Colors and Fonts: Basic Text Font = Fira Code 12.


### GNOME

    ./gnome-settings.sh

Launch `gnome-tweaks` and configure:

* _Startup Applications_, `+` _Kitty_ and _Chrome/Firefox_.
  This puts (copies of, not symlinks to) `firefox.desktop` and `kitty.desktop` into `~/.config/autostart/`.
* Edit ~~`~/.config/autostart/kitty.desktop` and after `Exec=kitty` append `--start-as=fullscreen`.
* Windows Focus on Hover

In _Gnome Terminal's Preferences_, add a new `tmux` Profile, and _Set as default_, with:
* Text _Custom Font_ `Fira Code Retina` Size 20. NB: [Fira Code's README](https://github.com/tonsky/FiraCode#terminal-support) lists GNOME Terminal as not supported, and the fancy Ligatures indeed don't work (like they do e.g. in Eclipse after changing the ), but I'm not actually seeing any real problems such as [issue #162](https://github.com/tonsky/FiraCode/issues/162), so it, just for consistency. (The alternative would be to just use `Fira Mono` from `mozilla-fira-mono-fonts` instead.)
* Scrolling disable _Show scrollbar_ and _Scroll on output_, but enable _Scroll on keystroke_, and _Limit scrollback to: 10'000 lines_
* Command: Replace initial title, Run a custom command instead of my shell: `tmux-local new -A -X -s MAKEx`

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
