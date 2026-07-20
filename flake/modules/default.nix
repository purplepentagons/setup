{ config, lib, ... }: {
	imports = [
		./packages.nix
		./dotfiles.nix
		./disks.nix
		
		./shell
		./style
	];
}g