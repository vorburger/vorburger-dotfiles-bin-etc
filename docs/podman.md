# _"Podman in Podman"_

See [the related official documentation](https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md),
and [this blog post](https://www.redhat.com/sysadmin/podman-inside-container); the TL;DR is:

On the "server", run [setup.sh](../setup.sh). This enables the SSH daemon and Podman Socket. Test it:

    podman --remote --url unix://run/user/$UID/podman/podman.sock info

In the container running on the "client", do e.g. the following if you like ;-) "inception":

    podman run -it --rm -v /run/user/$UID/podman:/run/user/0/podman --security-opt label=disable fedora
    dnf install -y podman-remote
    podman-remote info
    podman-remote run -it --rm fedora

_TODO See the TBD container image based on this._
