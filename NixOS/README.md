# NixOS

Start a VM with:

    QEMU_NET_OPTS="hostfwd=tcp::2222-:22" nix run .

Then login to it with:

    ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" root@localhost -p 2222
