{ alib, config, lib, ... }: let
	inherit (lib) mkOption;
	inherit (lib.types) path;
	inherit (alib.colors) recolorImage filterBase16Colors;
in {
	options.modules.style.wallpaper = mkOption {
		type = path;
	};

	# odd to have wallpapers in dotfiles, but whatever works
	config.home.file.".config/wallpaper.png".source = recolorImage {
		colors = (filterBase16Colors config.modules.style.colors);
		image = config.modules.style.wallpaper;
		luminosity = 0.4;
		preserveColors = true;
	};
}