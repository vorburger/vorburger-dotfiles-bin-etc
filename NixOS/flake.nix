{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+qSqOeDos2pCI1Q0tm44FgghgvOaX5WuPAXKRIw1/bwahPXnvTwJbSNdnIbQyDWZCmvJaXr6wnDP8faQBZcIyBBjD4JOoVONfvTw2/RKPHBB9eb6h8q6Jl1STsCk/8+Qv5PXhSjCJQ2mJdaE56wKrrPL/bIyOInx1KQj0rygV96KFj67CeXpjpMqOxAxcJyjp6/cxAGJyL81lcjA2HFKhwjeHS71ipOstmG+n6cOjd2x5V5Qv7j1x2zKSnxCJOU7PHphm7UqPUlvCcrKLq+YZ2VWSjjHiu+GUIR7dp1HG73W5uSmhgAM2fQEhldT53Lc2tCYwyrMq/C1hAtq/S26BxmibR8jmAxIqJ4JB9Njv/r97/6amI8LxnzuRBnDhA6cW9JHUBrNoG41vTwopdAz9DjaklzeRAjStoQY9rE6Ck6GXzuqUuLaBryS1JETKpxWvbQrnFA/yS9qFl/oDlfjYT0dX4oeWK58tCgdDD42SF4fUP6zpQZzHx4iwKGukMV3e87DW5tKTs2yCQzeBgw664mlG0WbYdj1TZ0n7MRXAr9aKpPSiW0H94A+0cZS/VJdVAxrRgbPv3Uk9W7E/tq4aMySRTm6ZlU0HTKlkg5adnQl5yM8ZxyOdYybnsq9ZyyUlsc9cmEfyOvIOP9cvi2pN5cpmDNG+pZ+mEHJ5aU95WQ==";

      # 1. Define the core modules for the *installed* system (excluding disk/mountpoints)
      baseModules = [
        # Common configuration
        (
          { pkgs, ... }:
          {
            system.stateVersion = "25.11";
            services.openssh.enable = true;

            # Use UEFI bootloader settings
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
          }
        )
      ];

      # 2. Full set of modules for the final installed system (includes disk mounts, SSH key)
      installedModules = baseModules ++ [
        disko.nixosModules.disko # Adds fileSystems/boot.loader config based on the disk layout
        {
          # Add the public key only to the real VM
          users.users.root.openssh.authorizedKeys.keys = [ sshKey ];
          disko.devices = {
            disk = {
              vda = {
                device = "/dev/vda";
                type = "disk";
                content = {
                  type = "gpt";
                  partitions = {
                    boot = {
                      size = "512M";
                      type = "EF00";
                      content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                      };
                    };
                    root = {
                      size = "100%";
                      content = {
                        type = "filesystem";
                        format = "ext4";
                        mountpoint = "/";
                      };
                    };
                  };
                };
              };
            };
          };
        }
      ];

      # 3. Create the installer VM
      nixosInstaller = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = installedModules;
      };

      # VM integration test that verifies SSH works.
      sshTest = pkgs.nixosTest {
        name = "ssh-test";
        nodes.machine =
          { pkgs, ... }:
          {
            # The test environment needs the full configuration (base + disk mounts)
            imports = installedModules;
          };
        testScript = ''
          machine.wait_for_unit("sshd.service")
          machine.succeed("whoami | grep root")
        '';
      };

    in
    {
      # The nixos-vm output now points to the installer closure
      nixosConfigurations.nixos-vm = nixosInstaller;

      # packages.default runs the installer VM
      packages.${system}.default = pkgs.writeShellScriptBin "run-vm" ''
        #!${pkgs.stdenv.shell}
        echo "Starting VM. It will automatically partition /dev/vda and install NixOS."
        echo "To stop VM, press Ctrl+A followed by X."
        exec ${nixosInstaller.config.system.build.vm}/bin/run-nixos-vm
      '';

      defaultPackage.${system} = self.packages.${system}.default;

      # The test can be run with `nix flake check` or `nix test`.
      checks.${system}.default = sshTest;
    };
}
