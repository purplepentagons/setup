{ alib, config, pkgs, lib, ... }: let

	inherit (builtins) listToAttrs elemAt;
	inherit (lib) mkOption nameValuePair concatMapAttrs mapAttrs';
	inherit (lib.strings) removeSuffix split;
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

	config.home.file = (concatMapAttrs (folder: location: 
		listToAttrs (map (file: 
			let
				has_mustache = hasExtension file ".mustache";
				# regex captures everything after the first occurance of "waybar/"
				# files from listFilesRecursive are absolute paths
				# https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFGuL_pXu7noqU-AnzpkdfQJ_1KgiQt2Jm0w&s
				config_file_name = elemAt (elemAt (
					split "${folder}\/(.*)" (removeSuffix ".mustache" (toString file))) 
				1) 0;
			in 
			nameValuePair ".config/${folder}/${config_file_name}" { 
				source = toString (if has_mustache then 
					applyConfigData file
				else file); 
			}
		) (listFilesRecursive location))
	) config.modules.dotfiles.folders) // 
	mapAttrs' (name: file: nameValuePair ".config/${name}" { source = toString (applyConfigData file); }) config.modules.dotfiles.files;
	
	#	# odd to have wallpapers in dotfiles, but whatever works
	#	".config/wallpapers/0057.png".source = recolorImage {
	#		colors = (filterBase16Colors config.modules.style.colors);
	#		image = ./wallpapers/0057.jpg;
	#		luminosity = 0.4;
	#		preserveColors = true;
	#	};
}