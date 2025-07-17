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

	# i couldn't come up with a more elegant regular expression, but these work well enough

	hexToRGB = color: if (stringLength color) == 6 then
		"rgb(" + (concatStringsSep "," (forEach (match "([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})" color) (hexNumber: fromHexString hexNumber))) + ")"
	else throw "Attempted to pass a hex color to hexToRGB, but did not receive a string with a length of 6.";

	# for hexToRGBA, alpha in rgba() is usually from 0 to 1, so normalize it from 255
}