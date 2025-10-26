MENU_OPTIONS="󰀻 Applications
󰎞 Notes
 Power
󱄠 Volume
󰛳 Networking
"
let MENU_ITEM_COUNT=$(echo "$MENU_OPTIONS" | wc -l)-1

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d -l "$MENU_ITEM_COUNT")

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
