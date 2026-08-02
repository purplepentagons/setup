{ pkgs, ... }: { 
	home.packages = with pkgs; [
		# packages in the config module are programs that don't require nix config/modules
		# file managers, password managers, htop/btop, alternatives to programs in coreutils

		thunar
		keepassxc
		mpv
		vscodium
		zathura

		# cli programs
		less
		btop
		eza
	];
}