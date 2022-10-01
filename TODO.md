- give talk about this? 1. Blog,  2. Friends,  3. at Work?

- JUST USE IT, to find gaps
  * initally NOT as toolbox, because that reads $HOME, but as sshd, with the systemd unit; with a GNOME Terminal Profile!
  * later [`useradd dotfiles`](https://github.com/vorburger/vorburger-dotfiles-bin-etc#fedora-based-container-with-ssh)
  * develop using `podman machine`, for best isolation?
  * LATER toolbox, perhaps try without mounting $HOME? Create a bug, for discussion.

- volume for persistent sshd hostkeys, to avoid StrictHostKeyChecking=no

- container: fish history should be preserved, mount ~/.local/share/fish/fish_history; see
  https://fishshell.com/docs/current/cmds/history.html#customizing-the-name-of-the-history-file

- container: ~/.ssh/known_hosts should be pre-initialized with github.com's

- container: `ssh ... localhost -- /home/vorburger/dev/vorburger-dotfiles-bin-etc/bin/tmux-ssh new -A -s dev`

- container: How does toolbox give accesss to podman.socket without requiring the chown?! It's a PITA, and would be nice to avoid, in an ideal world.

- container: https://docs.podman.io/en/latest/markdown/podman-auto-update.1.html ?
  This is better than --pull=newer, because it's more explicit. Also, newer isn't actually _newer_ but _different,_ which is a PITA during local development.

- README clean-up

- replace nano with micro

- ./container/build.sh must not depend on user presence SK touch to build,
  and uncomment test in container/build.sh, and unify or remove root ./test script.

- container clean-up: make container not use ~/git but store its files somewhere on / instead of anywhere in $HOME
- container: clone dotfiles to ~/git/ instead of ~/dev/ (but.. how? shouldn't git clone, because need local changes; must copy with .git)

- sshd doesn't seem to react to kill, so podman stop waits until timeout?
  Is there an orphan sshd at every restart?!

- "My Home Lab Data Center can be yours too!"

- https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#google-cloud-cos-vm-with-this-container-ssh-from-outside-into-container
  with persistence on an additional disk attached to the GCE VM...
  Either the entire $HOME with symlink-homefree.sh now, if that works.
  Alternatively, only $HOME/git - similar to https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#local-dev

- https://github.com/BurntSushi/ripgrep

- findx with fzf and open in nano at the matched line

- https://cloud.google.com/build/docs/kaniko-cache#docker-build?

- https://cloud.google.com/artifact-registry/docs/configure-cloud-build#docker

- scopatz/nanorc.git should be centralized in all-install.sh instead of spread all over (findx nanorc)

- finish full Toolbox support; see README.md

- clean up any remaining TODO (`findx TODO`)

- https://github.com/vorburger/Notes/blob/master/ToDo/shell-todo.txt

- https://github.com/vorburger/Notes/blob/master/ToDo/cloudshell-todo.md

- devshell: sl, fortune and cowsay + lolcat
  maybe every ... 13th ;) login?
  https://www.digitalocean.com/community/tutorials/top-10-linux-easter-eggs
  https://github.com/busyloop/lolcat
  https://opensource.com/article/18/12/linux-toy-lolcat
  https://www.tecmint.com/lolcat-command-to-output-rainbow-of-colors-in-linux-terminal/
