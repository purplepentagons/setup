{ pkgs, ... }: {
	home.packages = with pkgs; [
		work-sans
		inter
		atkinson-hyperlegible-next
		nerd-fonts.inconsolata
		nerd-fonts.atkynson-mono
		nerd-fonts.symbols-only
	];

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			monospace = [ "AtkynsonMono Nerd Font Propo" ];
			sansSerif = [ "Inter Display" ];
		};
	};
}