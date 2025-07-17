let 
	inherit (builtins) replaceStrings attrNames attrValues throw stringLength stringToCharacters concatStringsSep;
	inherit (lib) forEach toLower fromHexString;
in  {
	applyColors = {

		uiDark,
		uiLight,
		
		accent1,
		accent2,
		accent3,

	} @ colors: configFile: replaceStrings (
		forEach (attrNames colors) (entry: "$[" + (toLower entry) + "]")
	) (
		attrValues colors
	) configFile;
	
	hexToRGB = color: if (stringLength color) == 6 then
		# i couldn't come up with a more elegant regular expression, but this works well enough
		"rgb(" + (concatStringsSep "," (forEach (match "([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})" color) (hexNumber: fromHexString hexNumber))) + ")"
	else throw "Attempted to pass a hex color to hexToRGB, but did not receive a string with a length of 6.";
}