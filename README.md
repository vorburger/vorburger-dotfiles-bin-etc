# Vorburger.ch's Dotfiles

## Installation

### GitHub Codespaces

Enable _Automatically install dotfiles_ from this repository in [your GitHub Settings](https://github.com/settings/codespaces).

Press _Ctrl-Shift-P_ to _Turn on [Settings Sync](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#settings-sync)_ and _[Merge](https://code.visualstudio.com/docs/editor/settings-sync#_merge-or-replace)_. (Use [Settings Sync: Show Synced Data](https://code.visualstudio.com/docs/editor/settings-sync#_restoring-data) to view Synced Machines etc.)

To fix _Error loading webview: Error: Could not register service workers: NotSupportedError: Failed to register a ServiceWorker for scope ('...'): The user denied permission to use Service Worker_, [allow third-party cookies](https://stackoverflow.com/q/72498891/421602); e.g. on Chrome, add `[*.]github.dev` _Including third-party cookies_ on chrome://settings/cookies.

[Your GitHub Codespaces](https://github.com/codespaces) (only future, not existing) will be initialied by [bootstrap.sh](bootstrap.sh). If NOK, or to update:

    cd /workspaces/.codespaces/.persistedshare/dotfiles/
    tail -f ../creation.log   # still running?!
    ./bootstrap.sh

`git push` in `/workspaces/.codespaces/.persistedshare/dotfiles/` won't succeed while working in another repo; one way to still be able to push changes to dotfiles in this case is to [create a short-lived temporary personal access token](https://github.com/settings/tokens) and do `GITHUB_TOKEN=ghp_... git push`. [Here are other useful troubleshooting infos](https://docs.github.com/en/codespaces/troubleshooting/troubleshooting-dotfiles-for-codespaces). Testing during development is simplest by creating a codespace for this repo, and manually invoking `./bootstrap.sh`. ([My personal notes](https://github.com/vorburger/Notes/blob/master/Reference/github-codespaces.md) have some remaining TODOs.)

The `CODESPACES` [environment variable](https://docs.github.com/en/codespaces/developing-in-codespaces/default-environment-variables-for-your-codespace#list-of-default-environment-variables) should be used to skip anything long running that's not required in code spaces, e.g. the `nano` build.

### Fedora [Silverblue](https://silverblue.fedoraproject.org) & [CoreOS](https://github.com/vorburger/vorburger.ch-Notes/tree/develop/linux/coreos)

    mkdir ~/git/github.com/vorburger && cd ~/git/github.com/vorburger/
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc && cd vorburger-dotfiles-bin-etc
    ./setup.sh
    ./gnome-settings.sh
    ./toolbox.sh
    mux

These should later be more nicely integrated into the Toolbox container (not ~):

    ./symlink-toolbox.sh

Also, automatically start Toolbox in Fish instead of Bash...
and `./gnome-settings.sh` autostart Terminal Session TMUX, with Toolbox.
And run `~/.install-nano.sh` during `Dockerfile-toolbox`.


### Fedora Workstation

    mkdir -p ~/git/github.com/vorburger/ ~/git/github.com/scopatz/
    cd ~/git/github.com/scopatz/
    git clone https://github.com/scopatz/nanorc.git
    cd ~/git/github.com/vorburger/
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./setup.sh
    ./dnf-install.sh
    ./dnf-install-gui.sh
    ./all-install.sh
    mv ~/.bashrc ~/.bashrc.original
    ./symlink.sh

#### UHK

    ./etc.sh

Install _latest_ https://github.com/UltimateHackingKeyboard/agent/releases/,
and fix up path in [`UHK.desktop`](dotfiles/desktop/UHK.desktop).  Upgrade Firmware.
Remember to Export device configuration to [`keyboard/uhk/`](keyboard/uhk/UserConfiguration.json).


### Debian / Ubuntu Servers

    mkdir ~/dev/
    cd ~/dev/
    git clone https://github.com/scopatz/nanorc.git
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./debian-install.sh 11 # or ./ubuntu-install.sh
    mv ~/.bashrc ~/.bashrc.original
    ./symlink.sh
    ./setup.sh


### Fedora-based Container (with SSH)

This container includes SSH, based on [container/devshell](container/devshell),
so that one can login with an agent instead of keeping private keys in the container.

#### Local Dev

    ./container/build.sh
    ./container/run.sh
    ./container/ssh.sh

We can now work on this project in that container, like so:

    sudo chown vorburger:vorburger git/
    cd git
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc.git
    cd vorburger-dotfiles-bin-etc

    sudo chown vorburger:vorburger /run/user/1000/podman/podman.sock
    ./container/build.sh
    exit
    ./container/run.sh
    ./container/ssh.sh

NB that this will modify the ownership of `/run/user/1000/podman/podman.sock` on the host filesystem,
not only in the container. As long as we don't need to use `podman-remote` on the host, that shouldn't cause problems.


_TODO `ssh ... localhost -- /home/vorburger/dev/vorburger-dotfiles-bin-etc/bin/tmux-ssh new -A -s dev`_

#### Google Cloud COS VM with this container (SSH from outside into container)

[Set up a Cloud Build](cloudbuild.yaml), and then:

```
gcloud compute instances create-with-container dotfiles-fedora --project=vorburger --zone=europe-west6-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=MIGRATE --service-account=646827272154-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=projects/cos-cloud/global/images/cos-stable-93-16623-39-30 --boot-disk-size=10GB --boot-disk-type=pd-balanced --boot-disk-device-name=dotfiles-fedora2 --container-image=gcr.io/vorburger/dotfiles-fedora --container-restart-policy=always --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=container-vm=cos-stable-93-16623-39-30
```

_TODO `gcloud beta compute disks create home --project=vorburger --type=pd-ssd --size=10GB --zone=europe-west6-a`,
and then mount that into the container (above) - and switch to **`symlink-homefree.sh`** that doesn't use $HOME in container._

To login to the dotfiles container:

    ssh-add -L # MUST show local key/s, NOT "The agent has no identities"
    ssh -p 2222 -A vorburger@1.2.3.4

To enable SSH login to the host, not container, typically only required to check the container:

    gcloud --project=vorburger compute project-info add-metadata --metadata enable-oslogin=TRUE
    gcloud --project=vorburger compute os-login ssh-keys add --key-file=/home/vorburger/.ssh/id_ecdsa_sk.pub
    ssh michael_vorburger@1.2.3.4

### Google Cloud Shell

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_image=gcr.io/vorburger/vorburger-dotfiles-bin-etc)

_TODO [See this (pending) question on StackOverflow](https://stackoverflow.com/questions/70612890/non-ephemeral-google-cloud-shell-with-custom-container-image) about Google Cloud Shell Custom Images always lauched ephemeral; which makes it a No-Go for this project. (Simply running a dotfile devshell container on a GCE VM is much easier)._

https://shell.cloud.google.com, see https://cloud.google.com/shell, is handy (but limited to a `du -h ~` 5 GB `$HOME`..), especially with the web-based [Google Cloud Code](https://cloud.google.com/code), based on [Eclipse Theia](https://theia-ide.org) (also available on [Gitpod](https://www.gitpod.io)). To be able to connect to other servers from Google Cloud Shell, notably GitHub, login to it from a local Terminal like this (or use a Browser-based [Secure Shell App](https://chrome.google.com/webstore/detail/secure-shell-app/pnhechapfaindjhompbnflcldabbghjo?hl=en), based on https://hterm.org):

    gcloud cloud-shell ssh --ssh-flag="-A"

Alternatively, you COULD `ssh-keygen` and have something like the following in your `~/.ssh/config`, as per [this](https://github.com/aubort/google-cloud-shell-tutorial) or [this](https://vincentteo.com/2018/01/07/private-github-repos-google-cloud-shell/) guide, but security wise it's much better to keep your private SSH key e.g. a HSM YubiKey in your desktop/laptop, than having it on the cloud, so better don't this but use the approach above instead:

    Host github.com
	    Hostname github.com
	    PreferredAuthentications publickey
	    IdentityFile ~/.ssh/id_rsa

_TODO [See this (pending) question on StackOverflow](https://stackoverflow.com/questions/70612636/google-cloud-shell-ssh-with-customer-container-image) re. how to SSH login to Google Cloud Shell using a customer container image._

_TODO [See this (pending) question on StackOverflow](https://stackoverflow.com/questions/70608840/how-to-ssh-login-to-google-cloud-shell-using-an-existing-private-key-on-a-yubike) re. how to SSH login to Google Cloud Shell using an existing private key on a YubiKey security key._

To use the many configurations from this repo in Google Cloud Shell, simply use the big blue _"Open in Google Cloud Shell"_ above. This is [based on a customized image](https://cloud.google.com/shell/docs/customizing-container-image) available on [gcr.io/vorburger](https://gcr.io/vorburger). Here is how to "locally" build it for improvements to it:

    cd ~/git/github.com/vorburger/vorburger-dotfiles-bin-etc/
    cloudshell env build-local
    cloudshell env run

Watch out for `Connection to localhost closed.` after `env run` - it means that the container
cannot be SSH into, just like when "gcr.io/cloudshell-image/custom-image-validation" failed on a build,
e.g. due to a newer TMUX having been installed, or e.g. an infinite loop by
`/etc/inputrc` doing an `$include /etc/inputrc` by `symlink-homefree.sh`.

## Security

### SSH for multiple GitHub accounts

    git config core.sshCommand "ssh -i ~/.ssh/id_ecdsa_sk"

possibly with `[includeIf "gitdir:~/work/"]` in `~/.gitconfig`, as per https://dev.to/arnellebalane/setting-up-multiple-github-accounts-the-nicer-way-1m5m.

### `ssh` 101

    sudo dnf install -y pwgen diceware ; pip install xkcdpass
    # Generate a password/passphrase
    pwgen -s -y 239 1
    diceware -n 24 -d " " --no-caps
    xkcdpass -n 24

    ssh-keygen -t ed25519 -C $(id -un)@$(hostname)
    cat ~/.ssh/id_ed25519.pub

Copy/paste `~/.ssh/id_ed25519.pub` into https://github.com/settings/keys.

Now `sudo dnf install seahorse` (GNOME's Passwords and Keys) and when prompted, tick the checkbox about "unlocking keyring when logging in".

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

### `ssh` (incl. `git`) Agent incl. Forwarding with YubiKey

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


### `gpg` Agent Forwarding

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

#### On Fedora Silverblue

1. In _Gnome Terminal's Preferences_, add a new Profile as below,
   BUT name it `toolbox` and as Command, use:
   `sh -c 'echo "Type mux..." && toolbox enter vorburger-toolbox'`

#### On Fedora Workstation

Launch `gnome-tweaks` and configure:

* _Appearance > Themes > Applications_ switch to _Adwaita-**dark**_ mode for night mode
* _Startup Applications_, `+` _Kitty_ and _Chrome/Firefox_.
  This puts (copies of, not symlinks to) `firefox.desktop` and `kitty.desktop` into `~/.config/autostart/`.
* Edit ~~`~/.config/autostart/kitty.desktop` and after `Exec=kitty` append `--start-as=fullscreen`.
* Windows Focus on Hover

In _Gnome Terminal's Preferences_, add a new `tmux` Profile, and _Set as default_, with:
* Text _Custom Font_ `Fira Code Retina` Size 20. NB: [Fira Code's README](https://github.com/tonsky/FiraCode#terminal-support) lists GNOME Terminal as not supported, and the fancy Ligatures indeed don't work (like they do e.g. in Eclipse after changing the ), but I'm not actually seeing any real problems such as [issue #162](https://github.com/tonsky/FiraCode/issues/162), so it, just for consistency. (The alternative would be to just use `Fira Mono` from `mozilla-fira-mono-fonts` instead.)
* Scrolling disable _Show scrollbar_ and _Scroll on output_, but enable _Scroll on keystroke_, and _Limit scrollback to: 10'000 lines_
* Command: Replace initial title, Run a custom command instead of my shell: `mux`

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

### _"Podman-in-Podman"_

see [doc](docs/podman.md)


### Debian

    clear; time docker build -t vorburger-debian -f Dockerfile-debian . && docker run -it --hostname=debian --rm vorburger-debian

The `Dockerfile-debian-minimal` is used instead of `Dockerfile-debian` to rebuild faster with less for quick local iterative development.


### Toolbox

See above for usage with https://github.com/containers/toolbox.


### Google Cloud Shell

See above for usage as a https://cloud.google.com/shell/docs/customizing-container-image.

To local build test, try: `time docker build -t vorburger-google-cloudshell -f Dockerfile .` but it fails with:
`Error: error creating build container: writing blob: adding layer with blob "sha256:73b906f329a9204f69c7efa86428158811067503ffa65431ca008c8015ce7871": Error processing tar file(exit status 1): potentially insufficient UIDs or GIDs available in user namespace (requested 150328:89939 for /tinkey.bat): Check /etc/subuid and /etc/subgid: lchown /tinkey.bat: invalid argument`


### Vorburger's _DeCe_ Cloudshell

Using https://github.com/vorburger/cloudshell for a customized web shell on http://localhost:8080 :

    docker build -t vorburger-cloud -f Dockerfile-dece-cloudshell .
    docker run --hostname=cloud -eUSER_ID=vorburger -eUSER_PWD=THEPWD --rm -p 8080:8080 vorburger-cloud
