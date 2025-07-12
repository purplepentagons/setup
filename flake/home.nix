{ pkgs, stateVersion, system, username }: {
  home = {
    inherit stateVersion username;

    homeDirectory = "/home/${username}";
  };

  home.packages = import ./packages.nix { inherit pkgs; };

  nixpkgs.config.allowUnfree = true;

  home.file = import ./dotfiles.nix;

  programs.home-manager.enable = true;
}