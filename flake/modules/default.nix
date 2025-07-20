{ config, lib, ... }: {
	imports = [
		./aliases.nix
		./packages.nix
		./fonts.nix
		./colors.nix
		
		./dotfiles
		./programs
	];
}