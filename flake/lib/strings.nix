{ config, lib, pkgs, ... }: {
	config.functions.strings = {
		# https://pablo.tools/blog/computers/nix-mustache-templates/
		mustacheTemplate = data: template: name: pkgs.stdenv.mkDerivation {
			name = "${name}";

			nativeBuildinputs = with pkgs; [mustache-go];

			passAsFile = [ "jsonData" ];
			jsonData = builtins.toJSON data;

			phases = [ "buildPhase" "installPhase" ];

			buildPhase = ''
				${pkgs.mustache-go}/bin/mustache $jsonDataPath ${template} > rendered_file
			'';

			installPhase = ''
				cp rendered_file $out
			'';
		}; 
	};
}