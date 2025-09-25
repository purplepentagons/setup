{ pkgs, ... }: let
	# Vim doesn't open in a terminal when invoked outside of a terminal
	# This forces it to open in a terminal using foot's xterm compatibility
	vimTerminalFix = pkgs.makeDesktopItem {
		name = "vimtf";
		desktopName = "You shouldn't be seeing this.";
		terminal = true;
		exec = "foot -e vim %F";
		noDisplay = true;
		mimeTypes = [ "text/plain" ];
	};
in {
	home.packages = [
		vimTerminalFix
	];

	xdg.mimeApps.enable = true;

	xdg.mimeApps.associations.added = {
		"text/plain" = "vim.desktop";	
	};

	xdg.mimeApps.defaultApplications = {
		"text/html" = "vimtf.desktop";
		"text/markdown" = "vimtf.desktop";
		"text/plain" = "vimtf.desktop";

		"video/mp4" = "mpv.desktop";
		"video/webm" = "mpv.desktop";
		"video/mpeg" = "mpv.desktop";
		
		"audio/mpeg" = "mpv.desktop";
		"audio/wav" = "mpv.desktop";

		# to make sure links outside of firefox open in firefox
		"x-scheme-handler/http" = "firefox.desktop";
		"x-scheme-handler/https" = "firefox.desktop";
		"x-scheme-handler/chrome" = "firefox.desktop";
		"application/x-extension-htm" = "firefox.desktop";
		"application/x-extension-html" = "firefox.desktop";
		"application/x-extension-shtml" = "firefox.desktop";
		"application/xhtml+xml" = "firefox.desktop";
		"application/x-extension-xhtml" = "firefox.desktop";
		"application/x-extension-xht" = "firefox.desktop";
	};
}