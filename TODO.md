
- toolbox without mounting $HOME? Create a bug, for discussion.

- container: exercise https://github.com/vorburger/vorburger-dotfiles-bin-etc#local-dev @think

- container: `ssh ... localhost -- /home/vorburger/dev/vorburger-dotfiles-bin-etc/bin/tmux-ssh new -A -s dev`

- container: missing man pages

- container: fzf UI is ugly, wrong TERM, or LANG, or something?

- container: How does toolbox give accesss to podman.socket without requiring the chown?! It's a PITA, and would be nice to avoid, in an ideal world.

- volume for persistent sshd hostkeys, to avoid StrictHostKeyChecking=no

- give talk about this? 1. Blog,  2. Friends,  3. at Work?

- replace nano with micro

- container clean-up: make container not use ~/git but store its files somewhere on / instead of anywhere in $HOME
- container: clone dotfiles to ~/git/ instead of ~/dev/ (but.. how? shouldn't git clone, because need local changes; must copy with .git)

- sshd doesn't seem to react to kill, so podman stop waits until timeout?

- "My Home Lab Data Center can be yours too!"

- https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#google-cloud-cos-vm-with-this-container-ssh-from-outside-into-container
  with persistence on an additional disk attached to the GCE VM...
  Either the entire $HOME with symlink-homefree.sh now, if that works.
  Alternatively, only $HOME/git - similar to https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/README.md#local-dev

- remove Java 8 from dnf-install, add Java 17 instead

- https://github.com/BurntSushi/ripgrep

- findx with fzf and open in nano at the matched line

- ./container/build.sh must not depend on user presence SK touch to build,
  and uncomment test in container/build.sh, and unify or remove root ./test script.

- https://cloud.google.com/build/docs/kaniko-cache#docker-build?

- https://cloud.google.com/artifact-registry/docs/configure-cloud-build#docker

- scopatz/nanorc.git should be centralized in all-install.sh instead of spread all over (findx nanorc)

- finish full Toolbox support; see README.md

- add secure-ssh from https://github.com/labs-learn-study/labs.learn.study/tree/master/playbooks/roles

- clean up any remaining TODO (`findx TODO`)

- https://github.com/vorburger/Notes/blob/master/ToDo/shell-todo.txt

- https://github.com/vorburger/Notes/blob/master/ToDo/cloudshell-todo.md

- devshell: sl, fortune and cowsay + lolcat
  maybe every ... 13th ;) login?
  https://www.digitalocean.com/community/tutorials/top-10-linux-easter-eggs
  https://github.com/busyloop/lolcat
  https://opensource.com/article/18/12/linux-toy-lolcat
  https://www.tecmint.com/lolcat-command-to-output-rainbow-of-colors-in-linux-terminal/

- container: mount e.g. ~/work as volume from host? Nah, it's a PITA; forged about it.
