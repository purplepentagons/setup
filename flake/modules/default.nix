{ config, lib, ... }: {
	imports = [
		./packages.nix
		./fonts.nix
		./colors.nix
		
		./dotfiles
		./programs
		./shell
	];
}