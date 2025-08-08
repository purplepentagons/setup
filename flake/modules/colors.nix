{ config, lib, ... }: let
	inherit (builtins) length;
	inherit (lib) mkOption;
	inherit (lib.types) attrsOf listOf int addCheck;
in {
	options.modules.style.colors = mkOption {
		type = attrsOf (listOf (addCheck int (x: x >= 0 && x <= 255)));
	};
}