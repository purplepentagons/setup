{ pkgs, ... }: { 
  home.packages = with pkgs; [
    # no need to introduce unneeded complexity by seperating these
    # i'm not using nixos
    # i don't need a hyper complex config that works for both servers and desktops

    # gui programs
    foot
    xfce.thunar
    keepassxc
    signal-desktop
    mpv
    virt-manager
    vscodium
    zathura

    # cli programs
    less
    btop
    eza

    # wm related
    hyprshot
    rofi-wayland
    mako
    hyprpaper
    waybar

    # stuff i haven't figured out how to categorize
    usbutils
    udisks
    udiskie
  ];
}