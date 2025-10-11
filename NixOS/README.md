# NixOS

## Usage

To build the (small; ~6 MB!!) `nixos.qcow2` image and then implicitly start this VM through `result/bin/run-nixos-vm`, just use:

    QEMU_NET_OPTS="hostfwd=tcp::2222-:22" nix run .

Then login to it with:

    ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" root@localhost -p 2222

## More

To only build the `nixos.qcow2` image without starting it in QEMU, use:

    nix build .#nixosConfigurations.nixos-vm.config.system.build.vm

To build a (big; ~415 MB!) NixOS LiveCD `./result/iso/nixos*.iso` ISO image, use:

    nix build .#nixosConfigurations.nixos-vm.config.system.build.images.iso

This ISO can be booted e.g. in GNOME Boxes by finding its IP under _Preferences_ and `ssh root@192.168.122.36` (or whatever IP it got).
Under Fedora, you may need to `sudo chcon -t virt_content_t result/iso/*.iso` first (for SELinux) to avoid _"Could not open '...iso': Permission denied"_ error.

[See `docs/`](docs/) for more.
