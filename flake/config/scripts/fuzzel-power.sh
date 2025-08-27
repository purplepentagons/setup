MENU_OPTIONS="󰤂 Shutdown
󰗽 Log Out
󰜉 Reboot
"

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d)

case ${FUZZEL_RESULT:2} in
	"Shutdown")
		shutdown now ;;
	"Logout")
		killall -u $(whoami) ;;
	"Reboot")
		reboot ;;
esac