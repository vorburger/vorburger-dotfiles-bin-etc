# Nix

See [parent README](../README.md#nix).

Many Thanks to [@leona-ya](https://github.com/leona-ya) for having gotten me started during [NixCon 2025](https://2025.nixcon.org)!

## Develop

To directly run it the first time on an already set-up machine with this, just:

    nix run nixpkgs#home-manager -- switch --flake ./dotfiles/home-manager

To update to latest on one machine after having pushed changes from another, either:

    nix flake update --flake github:vorburger/vorburger-dotfiles-bin-etc`
    home-manager switch --flake github:vorburger/vorburger-dotfiles-bin-etc?dir=dotfiles/home-manager

or, and simpler:

    git pull
    hms
