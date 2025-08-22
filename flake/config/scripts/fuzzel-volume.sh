CURRENT_VOLUME="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ print $5 }')"
#alias vol="pactl set-sink-volume @DEFAULT_SINK@"

# double percent signs to escape them (i use printf)
MENU_OPTIONS="󱄠 Set Volume (curr. $CURRENT_VOLUME)
󰸈 Mute
󰝝 Volume Up 10%
󰝞 Volume Down 10%
"

FUZZEL_RESULT=$(printf "%s" "$MENU_OPTIONS" | fuzzel -d)

# i can't use aliases in bash scripts for some reason
case ${FUZZEL_RESULT:2} in
	"Set Volume (curr. $CURRENT_VOLUME)")
		pactl set-sink-volume @DEFAULT_SINK@ "$(fuzzel -d)%" ;;
	"Mute")
		pactl set-sink-volume @DEFAULT_SINK@ "0%" ;;
	"Volume Up 10%")
		pactl set-sink-volume @DEFAULT_SINK@ "+10%" ;;
	"Volume Down 10%")
		pactl set-sink-volume @DEFAULT_SINK@ "-10%";;
esac