# Git Server Container

## ToDo

1. Mount host key, needs HostKey in sshd_conf.d
1. No sudo usermod -aG wheel "$NEW_UID"
1. run sshd as UID git instead of root
1. git-shell-commands to create repo?
1. sshd: Disable password login, Disable root user login, Disable Subsystem sftp
1. git: no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty
1. Disable git push --force on server side with a hook
1. Backup!
1. All remaining TODO, if any

## Usage

    ../build.sh

TODO document usage, based on the [`test`](test) ...

## Troubleshooting

If the `git clone` in `test` fails as follows, this is "just" a timing issue, as the `sshd` will take a short moment to
get ready when the container starts; the solution would be simply to increase the `sleep 1` in `test`:

    kex_exchange_identification: read: Connection reset by peer
    Connection reset by ::1 port 36619
    fatal: Could not read from remote repository.

## Background

* https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server
* https://git-scm.com/docs/git-shell

## Similar Projects

* https://github.com/jkarlosb/git-server-docker
* https://github.com/leonklingele/git-simpleserver
* https://github.com/qishibo/git-server
* https://github.com/marcellodesales/git-sshd-server-docker
* https://github.com/ZhongRuoyu/git-server/
* https://github.com/louisroyer-docker/git-server/
