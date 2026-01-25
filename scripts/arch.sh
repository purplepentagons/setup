pacman -S nix
systemctl enable nix-daemon.service
systemctl start nix-daemon.service

bash ./setup.sh