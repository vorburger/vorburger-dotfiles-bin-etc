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
      mkHomeConfig = { envUSER, envHOME }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit envUSER envHOME; };
        modules = [
          nix-index-database.homeModules.nix-index
          ./home.nix
        ];
      };

      # Read the current user from the environment so this flake works for any
      # user (e.g. 'vorburger' on a workstation or 'code' in a devcontainer).
      # This requires --impure evaluation.
      envUSER =
        let
          u = builtins.getEnv "USER";
          l = builtins.getEnv "LOGNAME";
        in
        if u != "" then u else l;
      envHOME = builtins.getEnv "HOME";
    in
    {
      homeConfigurations = {
        # Explicit configurations for common users to allow pure evaluation
        # (without --impure) for these specific users.
        vorburger = mkHomeConfig { envUSER = "vorburger"; envHOME = "/home/vorburger"; };
        code = mkHomeConfig { envUSER = "code"; envHOME = "/home/code"; };
      } // (if envUSER != "" && envUSER != "vorburger" && envUSER != "code" then {
        # Dynamic configuration for any other user when run with --impure.
        ${envUSER} = mkHomeConfig { inherit envUSER envHOME; };
      } else {});
    };
}
