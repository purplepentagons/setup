{ pkgs, ... }: { 
	home.packages = with pkgs; [
		# packages in the config module are programs that don't require nix config/modules
		# file managers, password managers, htop/btop, alternatives to programs in coreutils

		xfce.thunar
		keepassxc
		signal-desktop
		mpv
		virt-manager
		vscodium
		zathura

		# cli programs
		less
		btop
		eza
	];
}