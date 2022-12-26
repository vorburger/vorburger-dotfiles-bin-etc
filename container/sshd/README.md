# Usage

see [`test.sh`](test.sh), and also the [`devshell`](../devshell/).

## Troubleshooting

Change `-D` to `-eddd` in `Dockerfile`, (rebuild and) check `docker logs -f test-sshd`.
NB that _The server also will not fork and will only process one connection._ (`man sshd`),
the container has to be re-started after every test.

## TODO

1. automate user creation and pub key steps from `test.sh`, for arbitrary users - but without hard-coding them into the Dockerfile.
1. better create hostkeys dynamically on first use in script instead of during Dockerfile?
1. add-uid-key better while baking container, or as script in container called on use?

## An Alternative

https://docs.linuxserver.io/images/docker-openssh-server is very similar to this container:

    podman run -it --rm -p 2222:2222 -e USER_NAME=vorburger -e PUBLIC_KEY="..." lscr.io/linuxserver/openssh-server

    ssh -p 2222 vorburger@localhost

* Con
  * comes with a full process supervisor
  * writes logs into files in (or mounted into) the container instead of only STDOUT
* Pro
  * smaller image than my full Fedora-based one (but that doesn't really matter, to me)
