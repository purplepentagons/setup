{ pkgs, ... }: {
	home.packages = with pkgs; [
		# sans serif
		work-sans
		inter
		atkinson-hyperlegible-next

		# serif
		source-serif

		# nerd fonts
		nerd-fonts.inconsolata
		nerd-fonts.atkynson-mono
		nerd-fonts.symbols-only

		# cjk support
		noto-fonts-cjk-serif
	];

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			monospace = [ "AtkynsonMono Nerd Font Propo" ];
			sansSerif = [ "Inter Display" ];
			serif = [ "Source Serif 4 Display" ];
		};
	};
}