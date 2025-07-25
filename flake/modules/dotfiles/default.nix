{ config, lib, ... }: let

	inherit (builtins) replaceStrings attrNames attrValues throw concatStringsSep length toString elemAt map readFile readDir listToAttrs;
	inherit (lib) toHexString flatten;
	inherit (lib.lists) take;
	inherit (lib.strings) concatMapStringsSep concatMapStrings;

	listToHex = color: if (length color) == 3 || (length color) == 4 then 
		concatMapStrings (value: ((if value <= 15 then "0" else "") + toHexString value)) color
	else throw "Attempted to pass a color to listToHex, but did not receive a list with a length of 3 or 4.";

	listToRGB = color: if (length color) == 3 then 
		"rgb(" + (concatMapStringsSep "," (value: toString value) color) + ")"
	else if (length color) == 4 then 
		"rgba(" + (concatMapStringsSep "," (value: toString value) (take 3 color)) + "," + (toString ((elemAt color 3) / 255.0)) + ")"
	else throw "Attempted to pass a color to listToRGB, but did not receive a list with a length of 3 or 4.";

	applyColors = colors: configFile: replaceStrings (
		(map (entry: "hex[" + (entry) + "]") (attrNames colors)) ++ (map (entry: "rgb[" + (entry) + "]") (attrNames colors))
	) (
		(map (entry: listToHex entry) (attrValues colors)) ++ (map (entry: listToRGB entry) (attrValues colors))
	) configFile;

	applyConfigColors = configFile: applyColors (config.modules.color.colors) (readFile configFile);

in {  
	home.file = {
		# TODO: automate this so I don't have to specify config files in two places
		
		# folders
		".config/hypr/".source = ./hypr;

		# files which require color substitution
		".config/foot/foot.ini".text = (applyConfigColors ./foot/foot.ini);

		".config/waybar/style.css".text = (applyConfigColors ./waybar/style.css);
		".config/waybar/config.jsonc".source = ./waybar/config.jsonc;

		".config/mako/config".text = (applyConfigColors ./mako/config);

		# standalone files
		".config/starship.toml".source = ./no_folder/starship.toml;

		# odd to have wallpapers in dotfiles, but whatever works
		".config/wallpapers".source = ./wallpapers;
	};
}