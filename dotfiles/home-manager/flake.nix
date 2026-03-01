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
      # Read the current user from the environment so this flake works for any
      # user (e.g. 'vorburger' on a workstation or 'code' in a devcontainer).
      # Requires --impure evaluation (see nix-install.sh).
      envUSER = builtins.getEnv "USER";
      envHOME = builtins.getEnv "HOME";
    in
    {
      homeConfigurations.${envUSER} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # extraSpecialArgs passes through arguments to home.nix etc. modules
        extraSpecialArgs = { inherit envUSER envHOME; };
        modules = [
          nix-index-database.homeModules.nix-index

          ./home.nix
        ];
      };
    };
}
