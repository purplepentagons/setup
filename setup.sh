# This file will be used to install things such as home-manager, my home-manager config, and Nix itself.

# It does not currently work.
pacman -S nix
systemctl enable nix-daemon.service
systemctl start nix-daemon.service

# home-manager installation
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch --flake ~/setup/flake --extra-experimental-features "nix-command flakes pipe-operators" -b backup