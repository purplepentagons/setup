home-manager switch --flake ~/setup/flake

# reload home-manager dependent applications

# hyprctl dispatch exec waybar makes sure that waybar runs under wayland
killall .waybar-wrapped && hyprctl dispatch exec waybar &
killall .mako-wrapped && mako &
killall hyprpaper && hyprpaper &
hyprctl reload