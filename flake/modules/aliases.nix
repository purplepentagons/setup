{
	home.shellAliases = {
		# switch to home-manager flake
		# nxs = "home-manager switch --flake ~/setup/flake";
		
		# check home-manager flake
		hmc = "nix flake check ~/setup/flake";
		# inspect home-manager flake in nix repl
		hmi = "nix repl --expr \"builtins.getFlake \\\"/home/purplepentagons/setup/flake\\\"\"";
		# nix-shell -p <package>
		nsp = "nix-shell -p";

		# git commit -m <message>
		gcm = "git commit -m";
		# git push
		gps = "git push";
		# git clone <repo link>
		gcl = "git clone";
		# find file in git repo
		gfn = "git ls-files | grep";

		ls = "eza --icons";
	};
}