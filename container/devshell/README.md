# Usage

    docker run -d -p 2222:22 --name devshell devshell
    docker exec devshell add-uid-key $USERNAME "$(cat ~/.ssh/authorized_keys)"
    ssh -A -p 2222 localhost
    ssh git@github.com

_TODO volume mapping to persist ongoing dev work._

## Troubleshooting

see the [sshd container](../sssh/).
