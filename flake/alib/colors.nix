{ config, lib, ... }: let 
	inherit (builtins) length toString elemAt;
	inherit (lib) toHexString concatMapAttrs;
	inherit (lib.strings) concatMapStrings concatMapStringsSep;
	inherit (lib.lists) take;
in {
	config.functions.colors = {
		listToHex = color: if (length color) == 3 || (length color) == 4 then 
			concatMapStrings (value: ((if value <= 15 then "0" else "") + toHexString value)) color
		else throw "expected a list with a length of 3 or 4";

		listToRGB = color: if (length color) == 3 then 
			"rgb(" + (concatMapStringsSep "," (value: toString value) color) + ")"
		else if (length color) == 4 then 
			"rgba(" + (concatMapStringsSep "," (value: toString value) (take 3 color)) + "," + (toString ((elemAt color 3) / 255.0)) + ")"
		else throw "expected a list with a length of 3 or 4";

		genStringReplacementList = colorList: (concatMapAttrs (name: color: {
			"${name}_hex" = config.functions.colors.listToHex color;
			"${name}_rgb" = config.functions.colors.listToRGB color;
		}) colorList);
	};
}