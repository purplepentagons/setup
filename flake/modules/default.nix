{ config, lib, ... }: {
	imports = [
		./packages.nix
		
		./style
		./dotfiles
		./programs
		./shell
	];
}