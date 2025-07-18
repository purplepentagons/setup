let 
	inherit (builtins) replaceStrings attrNames attrValues throw concatStringsSep length toString elemAt map;
	inherit (lib) toHexString;
	inherit (lib.lists) take;
	inherit (lib.strings) concatMapStringsSep concatMapStrings;
in {
	applyColors = {

		uiDark ? [0 0 0 127],
		uiLight ? [0 0 0 76], 
		
		accent1 ? [ 255 0 0 ],
		accent2 ? [ 0 255 0 ],
		accent3 ? [ 0 0 255 ],

	} @ colors: configFile: replaceStrings (
		(map (entry: "#[" + (entry) + "]") (attrNames colors)) ++ (map (entry: "rgb[" + (entry) + "]") (attrNames colors))
	) (
		(listToHex (attrValues colors)) ++ (listToRGB (attrValues colors))
	) configFile;

	listToRGB = color: if (length Color) == 3 then 
		"rgb(" + (concatMapStringsSep "," (value: toString value) color) + ")"
	else if (length Color) == 4 then 
		"rgba(" + (concatMapStringsSep "," (value: toString value) (take 3 color)) + "," + (toString ((elemAt color 3) / 255)) + ")"
	else throw "Attempted to pass a color to listToRGB, but did not receive a list with a length of 3 or 4.";

	listToHex = color: if (length Color) == 3 || (length Color) == 4 then 
		"#" + (concatMapStrings (value: toHexString value) color)
	else throw "Attempted to pass a color to listToHex, but did not receive a list with a length of 3 or 4.";
}