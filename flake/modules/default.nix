{ config, lib, ... }: {
	imports = [
		./packages.nix
		
		./style
		./dotfiles # dotfiles will be kept in modules until I find a way to seperate config dotfiles and module dotfiles
		./shell
	];
}