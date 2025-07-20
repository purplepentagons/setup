{ pkgs, stateVersion, system, username, ... }: {

	imports = [
		./modules
		./rice.nix
	];

	home = {
		inherit stateVersion username;

		homeDirectory = "/home/${username}";
	};

	nixpkgs.config.allowUnfree = true;

	nix = {
		package = pkgs.nix;
	
		# for some reason, nix.options.experimental-features doesn't work
		# i'm forced to do this as a workaround
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	programs.home-manager.enable = true;
}