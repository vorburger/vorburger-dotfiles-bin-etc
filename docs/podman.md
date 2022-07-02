# Podman

## Volumes

The TL;DR is:

* For processes running with UID 0 as root in the container, without `podman --user`, one can simply use
  something like `-v $PWD:/project:Z` (such as [here](https://github.com/OASIS-learn-study/minecraft-storeys-maker/blob/30ee8109ac2c990e3990da3f022cc042dcb9cb06/make#L5),
  and [here](https://github.com/OASIS-learn-study/minecraft-storeys-maker/blob/637173ccbc76b3894ea913f6b38c36b2c5568cb2/test#L11)
  or [here](https://github.com/vorburger/Notes/blob/8d3a67eea7a3b56fc4cee59c2f88a0e43b0d07a7/Reference/rclone.md#container-eg-on-fedora-silverblue)).
  This "just works" because the root user in the container is mapped to the user running `podman` on the host;
  this can be seen e.g. by `podman info` and `idMappings` of `podman top`, which are
  based on `/etc/subuid` & `/etc/subgid`, see `man newuidmap` (`man newgidmap`).

* Otherwise, it's... more complicated. `podman unshare` is one way, but after a `chown` it's not really usable 
  normally on the host anymore - so that's kind of pointless. Therefore, separating in-container data on
  a `podman volume` makes more sense. _(TODO: Explore create --opt=o=uid=1000,gid=1000._
  _Also is there actually/how to use the `btrfs` driver?)_

* _TODO: Using `-v $PWD:/project:Z,U` is an option still to explore further._

See [the official doc](https://docs.podman.io/en/latest/volume.html),
and [this blog post](https://www.redhat.com/sysadmin/rootless-podman-makes-sense)
and [another blog post](https://www.redhat.com/sysadmin/debug-rootless-podman-mounted-volumes),
and [that blog post](https://opensource.com/article/18/12/podman-and-user-namespaces).

    $ podman volume create dotfiles-work
    $ podman volume inspect dotfiles-work
    $ ls ~/.local/share/containers/storage/volumes/dotfiles-work/_data

    $ podman info
    (...)
    idMappings:
      gidmap:
      - container_id: 0
        host_id: 1000
        size: 1
      - container_id: 1
        host_id: 100000
        size: 65536
      uidmap:
      - container_id: 0
        host_id: 1000
        size: 1
      - container_id: 1
        host_id: 100000
        size: 65536

    $ podman top dotfiles user,huser,group,hgroup
    USER        HUSER       GROUP       HGROUP
    root        vorburger   root        vorburger
    root        vorburger   root        vorburger
    vorburger   100999      vorburger   100999
    vorburger   ?           vorburger   ?

_TODO_

    podman volume create
    podman volume ls
    podman volume rm
    podman volume prune


## _"Podman in Podman"_

See [the official doc](https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md),
and [this blog post](https://www.redhat.com/sysadmin/podman-inside-container); the TL;DR is:

On the "server", run [setup.sh](../setup.sh). This enables the SSH daemon and Podman Socket. Test it:

    podman --remote --url unix://run/user/$UID/podman/podman.sock info

In the container running on the "client", do e.g. the following if you like ;-) "inception":

    podman run -it --rm -v /run/user/$UID/podman:/run/user/0/podman --security-opt label=disable fedora
    dnf install -y podman-remote
    podman-remote info
    podman-remote run -it --rm fedora

_TODO See the TBD container image based on this._
