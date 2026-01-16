{ config, lib, ... }: let
	inherit (builtins) length;
	inherit (lib) mkOption;
	inherit (lib.types) attrsOf listOf int addCheck str;
in {
	imports = [
		./wallpaper.nix
	];

	options.modules.style = {
		colors = mkOption {
			type = attrsOf (listOf (addCheck int (x: x >= 0 && x <= 255)));
			default = { 
				# these colors are awful on purpose, please use your own colors
				background = [ 0 0 0 ];
				bright_background = [ 127 127 127 ];
				foreground = [ 255 255 255];

				black = [ 0 0 0 ];
				red = [ 255 0 0 ];
				green = [ 0 255 0 ];
				yellow = [ 255 255 0];
				blue = [ 0 0 255 ];
				magenta = [ 255 0 255 ];
				cyan = [ 0 255 255 ];
				white = [ 180 180 180 ];
				bright_black = [ 70 70 70 ];
				bright_red = [ 255 70 70 ];
				bright_green = [0 255 70 ];
				bright_yellow = [ 255 255 127 ];
				bright_blue = [ 127 127 255 ];
				bright_magenta = [ 255 127 255 ];
				bright_cyan = [ 127 255 255 ];
				bright_white = [ 220 220 220 ];
			};
		};

		arrow = mkOption {
			type = str;
			default = ">";
		};
	};
}