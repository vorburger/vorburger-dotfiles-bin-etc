# NixOS Image Types

The README's `nixosConfiguration.config.system.build.vm` is from
https://github.com/NixOS/nixpkgs/blob/25.05/nixos/modules/virtualisation/qemu-vm.nix.

To only build the `result/bin/run-nixos-vm` script, without starting it in QEMU via `nix run .` use:

    nix build .#nixosConfigurations.nixos-vm.config.system.build.vm

With `nix build .#nixosConfigurations.nixos-vm.config.system.build.qemu-efi` we can
build a `result/nixos-image-efi-*.qcow2` image, but there is no start-up script for it?

See https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/image/images.nix
for all other available `nixosConfigurations.nixos-vm.config.system.build.images.*` types.

We use `images.iso` (~415 MB) instead of `images.iso-installer` (~1.2 GB)
because the latter builds the standard NixOS installer ISO image (without our SSH key etc.),
which is not what we want here.
