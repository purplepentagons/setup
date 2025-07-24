home-manager switch --flake ~/setup/flake

# reload home-manager dependent applications
killall .waybar-wrapped && waybar &
killall hyprpaper && hyprpaper &
killall .mako-wrapped && mako &
hyprctl reload