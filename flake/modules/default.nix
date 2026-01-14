{ config, lib, ... }: {
	imports = [
		./packages.nix
		./dotfiles.nix
		
		./shell
		./style
	];
}