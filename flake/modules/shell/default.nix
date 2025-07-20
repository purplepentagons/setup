{ pkgs, ... }: let
	inherit (builtins) readDir readFile attrNames match replaceStrings; 
in {
	home.packages = map (
		path: (pkgs.writeShellScriptBin (
			replaceStrings (match ".*(\\.[0-9a-z]+$)" path) [ "" ] path
		) (
			readFile (./scripts + ("/" + path))
		) )
	) (
		attrNames (readDir ./scripts)
	);
}