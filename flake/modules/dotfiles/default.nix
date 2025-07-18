{ helpers, ... }: let
	colors = import ../colors.nix;
	applyConfigColors = file: helpers.applyColors (import ../colors.nix) (builtins.readFile file);
in {  

	home.file = {
		".config/hypr/".source = ./hypr;
		".config/foot/".source = ./foot;
		".config/waybar/style.css".text = (applyConfigColors ./waybar/style.css);
		".config/waybar/config.jsonc".source = ./waybar/config.jsonc

		# odd to have wallpapers in config, but whatever works
		".config/wallpapers".source = ../wallpapers;
	};
}