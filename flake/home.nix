{ pkgs, stateVersion, system, username }: {
  home = {
    inherit stateVersion username;

    homeDirectory = "/home/${username}";
  };

  home.packages = import ./packages.nix { inherit pkgs; };

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  home.file = import ./dotfiles.nix;

  programs.home-manager.enable = true;
}