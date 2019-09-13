# Usage

    docker run -d -p 2222:22 --name test-sshd sshd
    # docker exec -it test-sshd bash

    docker exec test-sshd useradd vorburger

    # TODO how to avoid having to do this??
    # docker exec test-sshd dnf install -y passwd
    # docker exec -it test-sshd passwd vorburger 

    docker cp ~/.ssh/my_public_key test-sshd:/home/vorburger/.ssh/authorized_keys

    ssh -p 2222 localhost

    docker rm -f test-sshd
