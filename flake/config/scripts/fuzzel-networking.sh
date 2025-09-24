# make sure the network list is fresh, eliminates some annoying wait time
nmcli device wifi list > /dev/null &

WIFI_ENABLED=$(nmcli radio wifi)

MENU_OPTIONS="󰀻 Ethernet
󰎞 WiFi ($WIFI_ENABLED)
"

FUZZEL_RESULT=$(printf "%s" "$MENU_OPTIONS" | fuzzel -d)

case ${FUZZEL_RESULT:2} in
	"Ethernet")
		# TODO: write ethernet script
		fuzzel ;;
	"WiFi ($WIFI_ENABLED)")
		# TODO: later, add an icon which symbolizes the signal strength
		# TODO: add way to disconnect from a network

		# sed script fixes multiple issues with nmcli's output format which make it hard to use with awk
		SED_SCRIPT='s/::/||/g;s/([^\\])(:)/\1|/g;s/\\:/:/g'
		AWK_SCRIPT='{ if ($2 != "") print $1,$2,$3,$7 }'
		WIFI_NETWORKS=$(nmcli -t device wifi list | sed -E "$SED_SCRIPT" | awk -F "|" -v OFS="|" "$AWK_SCRIPT")

		AWK_SCRIPT='{ print (($3 != "") ? $3 : $2) }'
		WIFI_NETWORK_SSIDS=$(printf "%s" "$WIFI_NETWORKS" | awk -F "|" "$AWK_SCRIPT")
		SECOND_FUZZEL_RESULT=$(printf "%s" "$WIFI_NETWORK_SSIDS" | fuzzel -d)
		CONNECTION_VERB="Connect"
		
		MENU_OPTIONS="󱘖 $CONNECTION_VERB
		"

		# grepping the ssid to make sure that nothing goes wrong
		echo "$WIFI_NETWORKS" | grep -q "$SECOND_FUZZEL_RESULT" && [ "$SECOND_FUZZEL_RESULT" != "" ] && \
		THIRD_FUZZEL_RESULT=$(printf "%s" "$MENU_OPTIONS" | fuzzel -d)

		case ${THIRD_FUZZEL_RESULT:2} in
			"Disconnect")
				nmcli connection down "$SECOND_FUZZEL_RESULT" ;;
			"Connect")
				# this does not need esc key prevention, you can skip password by doing this
				WIFI_PASSWORD=$(fuzzel -d -l 0 -p "Input password...")
				printf "%s" "$WIFI_PASSWORD" | nmcli device wifi connect "$SECOND_FUZZEL_RESULT" ;;
		esac
esac
