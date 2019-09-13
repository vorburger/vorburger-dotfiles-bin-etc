#!/usr/bin/env bash
set -euox pipefail

docker rm -f test-sshd || true
docker run -d -p 2222:22 --name test-sshd sshd
# docker exec -it test-sshd bash

docker exec test-sshd useradd vorburger

# This isn't required...
# docker exec test-sshd dnf install -y passwd
# docker exec -it test-sshd passwd vorburger

# NOK; see TODO
docker cp ~/.ssh/my_public_key test-sshd:/home/vorburger/.ssh/authorized_keys
# docker cp ~/.ssh/authorized_keys test-sshd:/home/vorburger/.ssh/
docker exec test-sshd chown -R vorburger:vorburger /home/vorburger/.ssh
docker exec test-sshd chmod 700 /home/vorburger/.ssh

# TODO comment this out, when it works
docker exec test-sshd ls -al /home/vorburger/
docker exec test-sshd ls -al /home/vorburger/.ssh/

ssh -p 2222 localhost echo "hello, world."

docker rm -f test-sshd
