{
	home.shellAliases = {
		# switch to home-manager flake
		nxs = "home-manager switch --flake ~/setup/flake";
		
		# check home-manager flake
		nfc = "nix flake check ~/setup/flake";

		# inspect home-manager flake
		nfi = "nix repl --expr \"builtins.getFlake \\\"/home/purplepentagons/setup/flake\\\"\"";

		ls = "eza --icons";
	};
}