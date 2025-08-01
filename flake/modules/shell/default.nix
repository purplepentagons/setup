{ alib, pkgs, ... }: let
	inherit (builtins) readDir readFile attrNames match replaceStrings; 
	inherit (alib.path) getExtension;
in {
	home.packages = map (
		path: (pkgs.writeShellScriptBin (
			# regex here gets file extension including period
			# this use of match returns a list with one item so I don't do anything else
			replaceStrings [ (getExtension path) ] [ "" ] path
		) (
			readFile (./scripts + ("/" + path))
		) )
	) (
		attrNames (readDir ./scripts)
	);
}