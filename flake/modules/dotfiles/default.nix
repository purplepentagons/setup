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

	# this doesn't have support for nested folders, i'll add it when it's necessary
	placeConfigFolders = folders: listToAttrs ( flatten ( map ( folder:
		map (file: 
			{
				name = (".config/${folder}/" + file);
				value = {
					text = (applyConfigColors ./${folder}/${file});
				};
			}
		) (attrNames (readDir ./${folder}))
	) folders ) );

in {  
	home.file = {
		".config/starship.toml".source = ./no_folder/starship.toml;
		".config/wallpapers".source = ./wallpapers;
	} // placeConfigFolders [
		"foot"
		"hypr"
		"mako"
		"waybar"
	];
}