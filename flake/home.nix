{ pkgs, stateVersion, system, username }: {
  home = {
    inherit stateVersion username;

    homeDirectory = "/home/${username}";
  };

  home.packages = import ./packages.nix { inherit pkgs; };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
  
    # for some reason, nix.options.experimental-features doesn't work
    # i'm forced to do this as a workaround
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  home.file = import ./dotfiles.nix;

  programs.home-manager.enable = true;
}