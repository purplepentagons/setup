{ pkgs, ... }: {
	home.packages = with pkgs; [
		work-sans
		nerd-fonts.inconsolata
		nerd-fonts.symbols-only
	];

	fonts.fontconfig.enable = true;
	fonts.fontconfig.defaultFonts = {
		monospace = [ "Inconsolata Nerd Font Propo" ];
		sansSerif = [ "Work Sans" ];
	};
}