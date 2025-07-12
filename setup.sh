# This file will be used to install things such as home-manager, my home-manager config, and Nix itself.

# home-manager installation
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch --flake ~/setup