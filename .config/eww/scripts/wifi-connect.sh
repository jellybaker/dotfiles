#!/usr/bin/env bash
# wifi-connect.sh — Connect to or disconnect from a WiFi network
# Usage: wifi-connect.sh connect   <ssid>
#        wifi-connect.sh disconnect

case "$1" in
    connect)
        ssid="$2"
        if [[ -z "$ssid" ]]; then echo "No SSID provided" >&2; exit 1; fi
        nmcli device wifi connect "$ssid" 2>&1
        ;;
    disconnect)
        nmcli device disconnect "$(nmcli -t -f DEVICE,TYPE device | grep ':wifi' | cut -d: -f1 | head -1)" 2>&1
        ;;
    toggle)
        state=$(nmcli radio wifi)
        if [[ "$state" == "enabled" ]]; then
            nmcli radio wifi off
        else
            nmcli radio wifi on
        fi
        ;;
    status)
        # Output JSON for eww: {"enabled": true, "ssid": "MyNet", "signal": 72}
        wifi_state=$(nmcli radio wifi)
        enabled="false"
        [[ "$wifi_state" == "enabled" ]] && enabled="true"

        connected_ssid=$(nmcli -t -f ACTIVE,SSID device wifi list 2>/dev/null \
            | grep '^yes:' | cut -d: -f2- | head -1)
        connected_signal=$(nmcli -t -f ACTIVE,SIGNAL device wifi list 2>/dev/null \
            | grep '^yes:' | cut -d: -f2 | head -1)
        connected_ssid="${connected_ssid//\"/\\\"}"

        printf '{"enabled":%s,"ssid":"%s","signal":%s}\n' \
            "$enabled" "${connected_ssid:-}" "${connected_signal:-0}"
        ;;
esac
