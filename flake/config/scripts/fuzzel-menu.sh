MENU_OPTIONS="󰀻  Applications
󰎞  Notes
  Power
󱄠  Volume
"

FUZZEL_RESULT=$(printf "$MENU_OPTIONS" | fuzzel -d --minimal-lines $@)

case ${FUZZEL_RESULT:3} in
	"Applications")
		fuzzel $@;;
	"Notes")
		fuzzel-note $@;;
	"Power")
		fuzzel-power $@;;
	"Volume")
		fuzzel-volume $@;;
esac
