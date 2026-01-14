{ config, lib, pkgs, ... }: let
	inherit (builtins) readFile typeOf; 
	inherit (lib) mkOption mkIf mapAttrsToList ; 
	inherit (lib.types) attrsOf str nullOr oneOf path;
in {
	options.modules.shell =  {
		scripts = mkOption {
			type = nullOr (attrsOf (oneOf [str path]));
		};

		aliases = mkOption {
			type = attrsOf str;
			default = {
				ls = "ls --color";
			};
		};
	};

	config.home.packages = mkIf (config.modules.shell.scripts != null) (
		config.modules.shell.scripts |> mapAttrsToList (name: script: pkgs.writeShellScriptBin name (
			if typeOf script == "str" then 
				script
			else if typeOf script == "path" then
				readFile script
			else throw "How?"
		))
	);

	config.home.shellAliases = mkIf (config.modules.shell.aliases != null) config.modules.shell.aliases;
}