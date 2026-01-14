{ lib, pkgs, ... }: let 
	inherit (builtins) typeOf toString elemAt;
in {
	config.functions.path = rec {
		# returns with period
		getExtension = file: let regex = ".*(\\.[0-9a-z]+$)"; in 
		if typeOf file == "path" then
			elemAt (builtins.match regex (toString file)) 0
		else if typeOf file == "string" then 
			elemAt (builtins.match regex file) 0
		else throw "expected either a set or a path";

		hasExtension = file: extension: (getExtension file) == extension;
	};
}