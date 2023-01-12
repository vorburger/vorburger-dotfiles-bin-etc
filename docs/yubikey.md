# YubiKey

## TL;DR

1. GPG and its SSH Agent are configured by `gpg.conf` and `gpg-agent.conf` in `~/.gnupg/`, which this set-up symlinks
2. `SSH_AUTH_SOCK` is set (only) inside the TMUX inside _Kitty,_ NOT on _Terminal_ by this set-up
3. On a new machine, you have to first once time manually import the public key, and trust it.

## Background

_TODO Merge all of my Notes/../yubikey.md here?_

_TODO Move all existing YubiKey related content from `README` here when cleaning up the README..._

## Troubleshooting

### `ssh-add -l` fails

    $ ssh-add -L
    Error connecting to agent: No such file or directory

    $ ll $SSH_AUTH_SOCK
    /home/vorburger/.ssh.agent ⇒ /run/user/1000/gnupg/S.gpg-agent.ssh

    $ ll -L $SSH_AUTH_SOCK
    lsd: /home/vorburger/.ssh.agent: No such file or directory (os error 2).

This is because the `gpg-agent` daemon was not running, yet (see `man gpg-agent` for related details); we COULD fix this like this:

    $ systemctl --user enable --now gpg-agent-ssh.socket
    $ ssh-add -L
    ssh-...
    $ systemctl --user status gpg-agent-ssh.socket
    $ systemctl --user status gpg-agent

BUT we prefer not to do this, as this interferes with support GPG over SSH; see Notes/../yubikey.md.

Background:

* There may be x2 such GPG Agent processes running (at least on Fedora Workstation) - one for the `root` user which was launched by `systemd` for `packagekit`, and one for the _"normal"_ user.

* `gpgconf --launch gpg-agent` is another way to explicitly start it (as a daemon); see `man gpgconf` for background.  Alternatively, `systemctl status` may show that `seahorse` started it, via [D-Bus Activation](https://wiki.gnome.org/HowDoI/DBusApplicationLaunching).

* Note `gpgconf --list-components` showing that in addition to `gpg-agent`, GPG has other moving parts, notably the `scdaemon`; consider using `gpgconf --kill all` (and `gpgconf --launch all`) to affect all such components which are daemons. Note also that `scdaemon` appears to be launched as a child process of (and ergo presumably by) `gpg-agent`.

* `gpgconf --kill gpg-agent` kills a `gpg-agent`.

### `ssh-add -l` is empty & `ssh git@github.com` NOK

* `$SSH_AUTH_SOCK` is probably not set to `gpg-agent`, but `/run/user/1000/keyring/ssh` ?
* This will work around it:

      SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket) ssh-add -l
      SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket) ssh git@github.com

* This set-up [makes this happen automatically](https://github.com/vorburger/vorburger-dotfiles-bin-etc/search?q=SSH_AUTH_SOCK) (only) in Kitty,
  via `~/.config/kitty/kitty.conf` use of `tmux-local` and `tmux3`,
  which sets `SSH_AUTH_SOCK` to `~/.ssh.agent` which symlinks to `/run/user/1000/gnupg/S.gpg-agent.ssh` (in `$XDG_RUNTIME_DIR`).

### `decryption failed: No secret key`

    $ pass test
    gpg: public key decryption failed: No secret key
    gpg: decryption failed: No secret key

This is because the secret keys are not yet available when setting up a new computer:

* `gpg --list-secret-keys` will return no results, nor will even `gpg --list-keys`.
* `gpg --card-status --with-keygrip` will appear to work - but note it's missing `ssb>`.

To fix this, you have to explicitly import the public key once, as this does not happen automatically; one way to do this (for me) is:

    curl https://www.vorburger.ch/gpg/vorburger.pgp.key.asc | gpg --import

Alternatively, use the following on another computer (this is how the file hosted on the previous URL was exported):

    gpg --armor --export 20BC9568C0DFA5B5A31E04E24DD7EC29BB91D899 > vorburger.pgp.key.asc

### `no assurance this key belongs to the named user`

    $ pass edit test
    gpg: 0xD087B3E45AE4FDE8: There is no assurance this key belongs to the named user
    gpg: /dev/shm/pass.ZqRl8iZKgzU0C/LveXvh-test.txt: encryption failed: Unusable public key
    GPG encryption failed. Would you like to try again? [y/N] N

This is fixed by doing the following, which is required when setting up a new computer:

    $ gpg --edit-key 4DD7EC29BB91D899
    gpg> trust
    (...)
    Your decision? 5
    Do you really want to set this key to ultimate trust? (y/N) y
    (...)
    gpg> quit

### `gpg --card-status` says `No such file or directory`

    $ gpg --card-status
    gpg: OpenPGP card not available: No such file or directory

This seems to happen when the YK SK is pulled out from USB and it gets confused; it can be fixed with:

    gpgconf --kill gpg-agent && gpg-connect-agent reloadagent /bye

### `gpg --card-status` says `No such device`

See https://github.com/vorburger/vorburger.ch-Notes/blob/develop/linux/fedora-upgrade.md#gpg-with-yubikey about this:

    $ gpg --card-status
    gpg: selecting card failed: No such device
    gpg: OpenPGP card not available: No such device

Solution was to `sudo dnf remove opensc` as per https://bugzilla.redhat.com/show_bug.cgi?id=1893131.

https://bugzilla.redhat.com/show_bug.cgi?id=1941346 seems a related bug.

NB: In a fresh Fedora 37 Workstation installation on 2022-12-28 this workaround was not required.

### `winscard.c:286:SCardConnect() Error Reader Exclusive`

    $ systemctl status pcscd
    ● pcscd.service - PC/SC Smart Card Daemon
        Loaded: loaded (/usr/lib/systemd/system/pcscd.service; indirect; preset: disabled)
        Active: active (running) since Wed 2022-12-28 01:02:31 CET; 15min ago
    TriggeredBy: ● pcscd.socket
        Docs: man:pcscd(8)
    Main PID: 22982 (pcscd)
        Tasks: 10 (limit: 38300)
        Memory: 2.0M
            CPU: 179ms
        CGroup: /system.slice/pcscd.service
                └─22982 /usr/sbin/pcscd --foreground --auto-exit

    Dec 28 01:02:31 poky systemd[1]: Started pcscd.service - PC/SC Smart Card Daemon.
    Dec 28 01:15:03 poky pcscd[22982]: 00000000 winscard.c:286:SCardConnect() Error Reader Exclusive
    Dec 28 01:15:03 poky pcscd[22982]: 00014859 winscard.c:286:SCardConnect() Error Reader Exclusive
    Dec 28 01:15:03 poky pcscd[22982]: 00016035 winscard.c:286:SCardConnect() Error Reader Exclusive
    (...)

TODO This can apparently be ignored?
