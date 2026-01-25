# Installs home-manager.

# home-manager installation
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch --flake ~/setup/flake --extra-experimental-features "nix-command flakes pipe-operators" -b backup