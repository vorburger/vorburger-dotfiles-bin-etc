{
  config,
  pkgs,
  lib,
  envHOME,
  ...
}:

{
  home = {
    username = "vorburger";
    # TODO Rip out the envHOME stuff, because it doesn't work anyway
    # homeDirectory = if envHOME != "" then envHOME else "/usr/local/google/home/vorburger";
    homeDirectory = if envHOME != "" then envHOME else "/home/vorburger";

    packages = with pkgs; [
      bat
      delta
      direnv
      fish
      fzf
      gh
      git
      lazygit
      sops
      tig
      trashy
      nil
      nixfmt
      nixd
      nodejs_24
      maven

      ripgrep
      wipe

      # TODO Install UI packages, but how-to only if on a machine with GUI?
      # kitty
      wl-clipboard
      # wofi-emoji (?)

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    ];

    activation.activate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      GIT_CMD=${pkgs.git}/bin/git $DRY_RUN_CMD ${../../git-clone.sh}
      $DRY_RUN_CMD "$HOME/git/github.com/vorburger/vorburger-dotfiles-bin-etc/symlink.sh"
    '';

    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/vorburger/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      EDITOR = "nano";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global = {
      warn_timeout = "30s";
      hide_env_diff = true;
    };
    silent = true;
  };
  programs.fish.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.home-manager.enable = true; # Lets Home Manager install and manage itself.
  programs.nix-index.enable = true;
}
