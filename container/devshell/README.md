# Usage

    docker run -d -p 2222:22 --name devshell devshell
    docker exec devshell add-uid-key $USERNAME "$(cat ~/.ssh/authorized_keys)"
    ssh -A -p 2222 localhost
    container$ ssh git@github.com

    docker rm -f devshell

_TODO volume mapping to persist ongoing dev work._

## Troubleshooting

see the [sshd container](../sshd/).
