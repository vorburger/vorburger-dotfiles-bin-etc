{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.livecd = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (
          { pkgs, modulesPath, ... }:
          {
            imports = [
             (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
            ];
          }
        )
      ];
    };
    livecd = self.nixosConfigurations.livecd.config.system.build.isoImage;
  };
}
