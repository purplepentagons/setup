MENU_OPTIONS="󰀻 Applications
󰎞 Notes
 Power
󱄠 Volume
󰛳 Networking
"

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d)

case ${FUZZEL_RESULT:2} in
	"Applications")
		fuzzel ;;
	"Notes")
		fuzzel-note ;;
	"Power")
		fuzzel-power ;;
	"Volume")
		fuzzel-volume ;;
	"Networking")
		fuzzel-networking ;;
esac
