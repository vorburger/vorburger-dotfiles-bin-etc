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

      # Function to create home configurations to avoid duplication.
      mkHomeConfig = { username }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Pass variables to home.nix. 
        # envHOME is empty ("") during pure evaluation, but gets $HOME if --impure is passed.
        extraSpecialArgs = { 
          inherit username; 
          envHOME = builtins.getEnv "HOME"; 
        };
        modules = [
          nix-index-database.homeModules.nix-index
          ./home.nix
        ];
      };
    in
    {
      homeConfigurations = {
        vorburger = mkHomeConfig { username = "vorburger"; };
        code = mkHomeConfig { username = "code"; };
      };
    };
}
