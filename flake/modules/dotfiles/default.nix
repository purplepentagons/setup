{ alib, config, pkgs, lib, ... }: let

	inherit (builtins) listToAttrs;
	inherit (lib) mkOption nameValuePair concatMapAttrs mapAttrs';
	inherit (lib.strings) removeSuffix;
	inherit (lib.types) attrsOf path;
	inherit (lib.filesystem) listFilesRecursive;
	inherit (alib.colors) genMustacheColorData recolorImage filterBase16Colors;
	inherit (alib.strings) mustacheTemplate;
	inherit (alib.path) hasExtension;

	applyConfigData = file: mustacheTemplate (
		(genMustacheColorData config.modules.style.colors) // {
			"disclaimer" = "This file was generated using a Mustache template.";
			"arrow" = config.modules.style.arrow;
		}
	) file (toString file); # i don't care about the package name here i'm not spending time cleaning something i'll never see
	
in {  
	options.modules.dotfiles = {
		folders = mkOption {
			type = attrsOf path;
		};

		files = mkOption {
			type = attrsOf path;
		};
	};

	# map the folders
	# then map the files

	# config.home.file = listToAttrs mapAttrs' 
	# 	({ folder, file }: let 
	# 			is_mustache = "true/false value if it's a mustache file or not";
	# 			config_file_name = "file name without .mustache extension";
	# 	in nameValuePair (
	# 		".config/${folder}/${config_file_name}"
	# 	) 
	# 		{ source = applyConfigData file; }
	# 	) (
	# 		# map the folders to a list of every config file
	# 		config.modules.dotfiles.folders
	# 	);

	config.home.file = (concatMapAttrs (folder: location: 
		listToAttrs map (file: 
			let
				has_mustache = hasExtension file ".mustache";
				config_file_name = removeSuffix ".mustache" (toString file);
			in 
			nameValuePair ".config/${folder}/${config_file_name}" { 
				source = if has_mustache then 
					applyConfigData file
				else file; 
			}
		) (listFilesRecursive location)
	) config.modules.dotfiles.folders) // 
	mapAttrs' (name: file: nameValuePair ".config/${name}" (applyConfigData file) ) config.modules.dotfiles.files;


	# } // {
	#	# TODO: seriously, automate this so I don't have to specify config files in two places
	#	
	#	# folders
	#	".config/hypr/hyprland.conf".source = (applyConfigData ./hypr/hyprland.conf.mustache);
	#	".config/hypr/hyprpaper.conf".source = (applyConfigData ./hypr/hyprpaper.conf);
	#
	#	# files which require color substitution
	#
	#	".config/fuzzel/fuzzel.ini".source = (applyConfigData ./fuzzel/fuzzel.ini.mustache);
	#	
	#	".config/foot/foot.ini".source = (applyConfigData ./foot/foot.ini.mustache);
	#
	#	".config/waybar/style.css".source = (applyConfigData ./waybar/style.css.mustache);
	#	".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
	#
	#	".config/mako/config".source = (applyConfigData ./mako/config.mustache);
	#
	#	# standalone files
	#	".config/starship.toml".source = (applyConfigData ./no_folder/starship.toml.mustache);
	#
	#	# odd to have wallpapers in dotfiles, but whatever works
	#	".config/wallpapers/0057.png".source = recolorImage {
	#		colors = (filterBase16Colors config.modules.style.colors);
	#		image = ./wallpapers/0057.jpg;
	#		luminosity = 0.4;
	#		preserveColors = true;
	#	};
	#};
}