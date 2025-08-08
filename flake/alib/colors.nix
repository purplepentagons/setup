{ config, lib, pkgs, ... }: let 
	inherit (builtins) length toString elemAt map toJSON attrValues filter elem;
	inherit (lib) toHexString concatMapAttrs optionalString filterAttrs;
	inherit (lib.strings) concatMapStrings concatMapStringsSep;
	inherit (lib.lists) take;
in {
	config.functions.colors = rec {
		listToHex = color: if (length color) == 3 || (length color) == 4 then 
			concatMapStrings (value: ((if value <= 15 then "0" else "") + toHexString value)) color
		else throw "expected a list with a length of 3 or 4";

		listToRGB = color: if (length color) == 3 then 
			"rgb(" + (concatMapStringsSep "," (value: toString value) color) + ")"
		else if (length color) == 4 then 
			"rgba(" + (concatMapStringsSep "," (value: toString value) (take 3 color)) + "," + (toString ((elemAt color 3) / 255.0)) + ")"
		else throw "expected a list with a length of 3 or 4";

		genMustacheColorData = colorList: concatMapAttrs (name: color: {
			"${name}_hex" = listToHex color;
			"${name}_rgb" = listToRGB color;
		}) colorList;

		# the default name is wallpaper because you're usually using this for a wallpaper
		recolorImage = {
			colors, 
			image, 
			name ? "wallpaper", 
			luminosity ? 0.1, 
			preserveColors ? true
		}: pkgs.stdenvNoCC.mkDerivation {
			name = "${name}";

			nativeBuildinputs = with pkgs; [ lutgen ];

			passAsFile = [ "colors" "image" ];
			colors = concatMapStringsSep "\n" ( color: "#${listToHex color}" ) ( attrValues colors );
			inherit image;

			phases = [ "buildPhase" "installPhase" ];

			buildPhase = ''
				# fixes issue with homeless_shelter directory
				export HOME=$(pwd)

				mkdir theme
				export LUTGEN_DIR=$HOME/theme
				cp $colorsPath ./theme/distortedprose

				# for some reason, the image file contains the path to the actual image, so I have to open it like a matryoshka doll
				cat $(cat $imagePath) > image

				${pkgs.lutgen}/bin/lutgen apply ./image -p distortedprose -${optionalString preserveColors "P"}L${toString luminosity} -o ./recolored_image.png
			'';

			installPhase = ''
				cp recolored_image.png $out
			'';
		};

		filterBase16Colors = colors: filterAttrs (n: v: elem n [
			"black"
			"red"
			"green"
			"yellow"
			"blue"
			"magenta"
			"cyan"
			"white"
			"bright_black"
			"bright_red"
			"bright_green"
			"bright_yellow"
			"bright_blue"
			"bright_magenta"
			"bright_cyan"
			"bright_white"
		]) colors;
	};
}