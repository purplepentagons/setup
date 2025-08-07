{ alib, config, pkgs, lib, ... }: let

	inherit (builtins) toString;
	inherit (lib) filterAttrs;
	inherit (lib.strings) hasPrefix;
	inherit (alib.colors) genMustacheColorData recolorImage filterBase16Colors;
	inherit (alib.strings) mustacheTemplate;

	applyConfigData = file: mustacheTemplate (
		(genMustacheColorData config.modules.color.colors) // {
			"disclaimer" = "This file was generated using a Mustache template..";
			"arrow" = "󰹞";
		}
	) file (toString file); # i don't care about the package name here i'm not spending time cleaning something i'll never see
	
in {  
	home.file = {
		# TODO: seriously, automate this so I don't have to specify config files in two places
		
		# folders
		".config/hypr/hyprland.conf".source = (applyConfigData ./hypr/hyprland.conf.mustache);
		".config/hypr/hyprpaper.conf".source = (applyConfigData ./hypr/hyprpaper.conf);

		# files which require color substitution

		".config/fuzzel/fuzzel.ini".source = (applyConfigData ./fuzzel/fuzzel.ini.mustache);

		".config/foot/foot.ini".source = (applyConfigData ./foot/foot.ini.mustache);

		".config/waybar/style.css".source = (applyConfigData ./waybar/style.css.mustache);
		".config/waybar/config.jsonc".source = ./waybar/config.jsonc;

		".config/mako/config".source = (applyConfigData ./mako/config.mustache);

		# standalone files
		".config/starship.toml".source = (applyConfigData ./no_folder/starship.toml.mustache);

		# odd to have wallpapers in dotfiles, but whatever works
		".config/wallpapers/0057.png".source = recolorImage {
			colors = (filterBase16Colors config.modules.color.colors);
			image = ./wallpapers/0057.jpg;
			luminosity = 0.4;
			preserveColors = true;
		};
	};
}