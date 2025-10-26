MENU_OPTIONS="󰤂 Shutdown
󰗽 Log Out
󰜉 Reboot
"
let MENU_ITEM_COUNT=$(echo "$MENU_OPTIONS" | wc -l)-1

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d -l "$MENU_ITEM_COUNT")

case ${FUZZEL_RESULT:2} in
	"Shutdown")
		shutdown now ;;
	"Logout")
		killall -u $(whoami) ;;
	"Reboot")
		reboot ;;
esac