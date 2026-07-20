{
	modules.shell.aliases = {
		# check home-manager flake
		hmc = "nix flake check ~/setup/flake";
		# inspect home-manager flake in nix repl
		hmi = "nix repl --expr \"builtins.getFlake \\\"/home/purplepentagons/setup/flake\\\"\"";
		nsp = "nix-shell -p";
		# switch home-manager config without reloading desktop
		hms = "home-manager switch --flake ~/setup/flake/";
		# i have nxs as muscle memory for my switch command
		nxs = "hms";
		# also muscle memory
		hmr = "refresh";

		gcm = "git commit -m";
		gph = "git push";
		gcl = "git clone";
		# find file in git repo
		gfn = "git ls-files | grep";

		# make cli programs fancier
		ls = "eza --icons";
		grep = "grep --color -i";
	};
}