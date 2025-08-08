{ pkgs, ... }: { 
	home.packages = with pkgs; [
		# packages in the modules module are packages that should be installed no matter what
		# terminal emulators, bars, notification daemons, etc

		# if I wipe the entirety of the config module, the system should be mostly functional
		# albeit lacking functionality or applications required to do anything

		# no need to introduce unneeded complexity by seperating these
		# i'm not using nixos
		# i don't need a hyper complex config that works for both servers and desktops

		# gui programs
		foot

		# cli programs
		starship

		# wm related
		hyprshot
		# rofi-wayland
		fuzzel
		mako
		hyprpaper
		waybar

		# packages i haven't figured out how to categorize
		usbutils
		udisks
		udiskie
	];
}