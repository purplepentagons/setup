{ config, lib, ... }: {
	imports = [
		./aliases.nix
		./packages.nix
		./fonts.nix
		
		./dotfiles
		./programs
	];
}