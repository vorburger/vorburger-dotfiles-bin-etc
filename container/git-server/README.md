# Git Server Container

## ToDo

1. All TODO
1. read-only container root filesystem
1. USER git ?
1. WORKDIR /git ?
1. No sudo usermod -aG wheel "$NEW_UID"
1. git-shell-commands to create repo?
1. sshd: Disable password login, Disable root user login
1. git: no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty
1. Disable git push --force on server side with a hook
1. Encrypted Backup! (Or not here, just part of volume management; better.)
1. Enforce/require signatures (git commit -S)

## Usage

TODO `systemd/git-server.service`, or _TODO this currently still fails with `git@localhost: Permission denied (publickey).`
(even though [`test`](test) works), but I don't understand why (is it because of permission on /git/.ssh? but it's the same in the test, no?), yet:_

    ../build.sh
    podman volume create git-server
    mkdir ~/.ssh/authorized_keys.git
    cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys.git/
    podman run -d -p 2223:2222 -v git-server:/git/ -v ~/.ssh/authorized_keys.git/:/home/git/.ssh/:ro,Z --name git-server git-server

    ssh -p 2223 git@localhost
    podman logs git-server

    podman exec git-server bash -c "mkdir /git/test-repo && cd /git/test-repo && git init --bare && chown -R git:git /git/"
    GIT_SSH_COMMAND="ssh -p 2223" git clone git@localhost:/git/test-repo

    podman rm -f -t=1 git-server

TODO How to avoid `GIT_SSH_COMMAND` just for the port?

See also the [`test`](test) to discover more usages.

## Troubleshooting

If the `git clone` in `test` fails as follows, this is "just" a timing issue, as the `sshd` will take a short moment to
get ready when the container starts; the solution would be simply to increase the `sleep 1` in `test`:

    kex_exchange_identification: read: Connection reset by peer
    Connection reset by ::1 port 36619
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.

## Background

* https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server
* https://git-scm.com/docs/git-shell

## Similar Projects

* https://github.com/charmbracelet/soft-serve
* https://github.com/jkarlosb/git-server-docker
* https://github.com/leonklingele/git-simpleserver
* https://github.com/qishibo/git-server
* https://github.com/marcellodesales/git-sshd-server-docker
* https://github.com/ZhongRuoyu/git-server/
* https://github.com/qishibo/git-server
* https://github.com/louisroyer-docker/git-server/
* https://github.com/chainguard-images/images/tree/main/images/git is a git client, not a server
