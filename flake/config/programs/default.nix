{
	imports = [
		./firefox

		./xdg.nix
		./system.nix
	];

	programs.bash.enable = true;
	programs.starship.enable = true;
}