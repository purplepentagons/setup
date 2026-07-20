home-manager switch --flake ~/setup/flake/ -b backup $@

# reload home-manager dependent applications

# hyprctl dispatch exec waybar makes sure that waybar runs under wayland
killall .waybar-wrapped
waybar &
killall mako
mako &
killall hyprpaper 
hyprpaper &