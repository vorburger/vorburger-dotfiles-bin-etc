#!/usr/bin/env bash
set -euox pipefail

docker rm -f test-sshd || true
docker run -d -p 2222:22 --name test-sshd sshd

docker exec test-sshd useradd vorburger
docker cp ~/.ssh/my_public_key test-sshd:/home/vorburger/.ssh/authorized_keys
docker exec test-sshd chown -R vorburger:vorburger /home/vorburger/.ssh
docker exec test-sshd chmod 700 /home/vorburger/.ssh

ssh -p 2222 localhost echo "hello, world."

docker rm -f test-sshd
