{ alib, config, pkgs, lib, ... }: let

	inherit (builtins) toString;
	inherit (alib.colors) genStringReplacementList;
	inherit (alib.strings) mustacheTemplate;

	applyConfigColors = file: mustacheTemplate (genStringReplacementList config.modules.color.colors) file (toString file);
	
in {  
	home.file = {
		# TODO: automate this so I don't have to specify config files in two places
		
		# folders
		".config/hypr/".source = ./hypr;

		# files which require color substitution
		".config/foot/foot.ini".source = (applyConfigColors ./foot/foot.ini.mustache);

		".config/waybar/style.css".source = (applyConfigColors ./waybar/style.css.mustache);
		".config/waybar/config.jsonc".source = ./waybar/config.jsonc;

		".config/mako/config".source = (applyConfigColors ./mako/config.mustache);

		# standalone files
		".config/starship.toml".source = ./no_folder/starship.toml;

		# odd to have wallpapers in dotfiles, but whatever works
		".config/wallpapers".source = ./wallpapers;
	};
}