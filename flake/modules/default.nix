{ config, lib, ... }: {
	imports = [
		./packages.nix
		./fonts.nix
		./style.nix
		
		./dotfiles
		./programs
		./shell
	];
}