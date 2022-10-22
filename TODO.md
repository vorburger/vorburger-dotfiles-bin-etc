# ToDo

## NeXT

- Activate `venv venv` whenever there is one in the current directory, with a Fish `cd` "event" (?) hook thing

- JUST USE IT, to find gaps
  * initally NOT as toolbox, because that reads $HOME, but as sshd, with the systemd unit; with a GNOME Terminal Profile!
  * later [`useradd dotfiles`](https://github.com/vorburger/vorburger-dotfiles-bin-etc#fedora-based-container-with-ssh)
  * develop using `podman machine`, for best isolation?
  * LATER toolbox, perhaps try without mounting $HOME? Create a bug, for discussion.

- set -x LC_ALL en_US.UTF-8, set -x LANG en_US.UTF-8; check Arch Wiki?

- make it (even?) easier to "power cycle" the container (script, doc)
  Perhaps a systemd unit "outside" could watch for a flag/tag file in a mounted directory,
  which restarts the container? (This overlaps a bit with `toolbox` systemd integration.)

- volume for persistent sshd hostkeys, to avoid StrictHostKeyChecking=no

- container: fish history should be preserved, mount ~/.local/share/fish/fish_history; see
  https://fishshell.com/docs/current/cmds/history.html#customizing-the-name-of-the-history-file

- container: ~/.ssh/known_hosts should be pre-initialized with github.com's:
  `ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts`

- README clean-up

- container: https://docs.podman.io/en/latest/markdown/podman-auto-update.1.html ?
  This is better than --pull=newer, because it's more explicit. Also, newer isn't actually _newer_ but _different,_ which is a PITA during local development.

- Kitty NOK: container/ssh.sh says, and likely because of this TMUX then doesn't work:
    warning: Could not set up terminal.
    warning: TERM environment variable set to 'xterm-kitty'.
    warning: Check that this terminal type is supported on this system.
    warning: Using fallback terminal type 'ansi'.


# GCE

- https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#google-cloud-cos-vm-with-this-container-ssh-from-outside-into-container
  with $HOME/git persistence on an additional disk attached to the GCE VM,
  similar to https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#local-dev

- https://cloud.google.com/artifact-registry/docs/configure-cloud-build#docker


# LATER

- replace nano with micro
- scopatz/nanorc.git should be centralized in all-install.sh instead of spread all over (findx nanorc)

- finish full Toolbox support; see README.md
- toolbox: How does toolbox give accesss to podman.socket without requiring the chown?! It's a PITA, and would be nice to avoid, in an ideal world.

- give talk about this? 1. Blog,  2. Friends,  3. at Work? ("My Home Lab Data Center can be yours too!")
- ./container/build.sh must not depend on user presence SK touch to build,
  and uncomment test in container/build.sh, and unify or remove root ./test script.

- container clean-up: make container not use ~/git but store its files somewhere on / instead of anywhere in $HOME
- container: clone dotfiles to ~/git/ instead of ~/dev/ (but.. how? shouldn't git clone, because need local changes; must copy with .git)

- sshd doesn't seem to react to kill, so podman stop waits until timeout?
  Is there an orphan sshd at every restart?!

- https://github.com/franciscolourenco/done

- https://github.com/meaningful-ooo/sponge

- https://github.com/BurntSushi/ripgrep

- findx with fzf and open in nano at the matched line

- clean up any remaining TODO (`findx TODO`)

- https://github.com/vorburger/Notes/blob/master/ToDo/shell-todo.txt

- https://github.com/vorburger/Notes/blob/master/ToDo/cloudshell-todo.md

- devshell: sl, fortune and cowsay + lolcat
  maybe every ... 13th ;) login?
  https://www.digitalocean.com/community/tutorials/top-10-linux-easter-eggs
  https://github.com/busyloop/lolcat
  https://opensource.com/article/18/12/linux-toy-lolcat
  https://www.tecmint.com/lolcat-command-to-output-rainbow-of-colors-in-linux-terminal/
