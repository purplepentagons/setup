{ lib, pkgs, ... }: let 
	inherit (lib) mkOption; 
in {
	imports = [
		./strings.nix
		./colors.nix
		./path.nix
	];

	options.functions = mkOption {
		type = lib.types.attrs;
	};
}