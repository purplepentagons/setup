{
	imports = [
		./firefox

		./xdg.nix
	];

	programs.bash.enable = true;
	programs.starship.enable = true;
}