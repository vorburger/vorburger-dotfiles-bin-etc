# Usage

    docker run -d --name devshell devshell
    docker exec devshell add-uid-key $USERNAME /bin/bash "$(cat ~/.ssh/authorized_keys)"
    ssh -A -p 2222 localhost
    container$ ssh git@github.com

    docker rm --force --time=1 devshell

_TODO volume mapping to persist ongoing dev work._

The `docker run -p 2222:22` port mapping is no longer required since we switched the default port to 2222 (for GCE).

## Troubleshooting

see the [sshd container](../sshd/).
