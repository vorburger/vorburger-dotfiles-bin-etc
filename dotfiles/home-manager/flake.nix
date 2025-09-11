{
  description = "Home Manager configuration of @vorburger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, home-manager, nix-index-database, ... }:
    let
      # TODO Support Mac...
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."vorburger" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # extraSpecialArgs passes through arguments to home.nix etc. modules
        extraSpecialArgs = { envHOME = builtins.getEnv "HOME"; };
        modules = [
          nix-index-database.homeModules.nix-index

          ./home.nix
        ];
      };
    };
}
