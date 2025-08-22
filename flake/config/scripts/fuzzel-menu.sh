MENU_OPTIONS="󰎞 Notes
󰀻 Applications
 Power
󱄠 Volume
"

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d)

case ${FUZZEL_RESULT:2} in
	"Notes")
		fuzzel-note ;;
	"Applications")
		fuzzel ;;
	"Power")
		fuzzel-power ;;
	"Volume")
		fuzzel-volume ;;
esac
