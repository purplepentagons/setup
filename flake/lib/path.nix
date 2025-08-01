{ lib, pkgs, ... }: let 
	inherit (builtins) typeOf toString;
in {
	config.functions.path = {
		getExtension = file: let regex = ".*(\\.[0-9a-z]+$)"; in 
		if typeOf file == "path" then
			builtins.match regex (toString file)
		else if typeOf file == "string" then 
			builtins.match regex file
		else throw "expected either a set or a path";
	};
}