{ pkgs, ... }: let
	inherit (builtins) readDir readFile attrNames match replaceStrings; 
in {
	home.packages = map (
		path: (pkgs.writeShellScriptBin (
			# regex here gets file extension including period
			# this use of match returns a list with one item so I don't do anything else
			replaceStrings (match ".*(\\.[0-9a-z]+$)" path) [ "" ] path
		) (
			readFile (./scripts + ("/" + path))
		) )
	) (
		attrNames (readDir ./scripts)
	);
}