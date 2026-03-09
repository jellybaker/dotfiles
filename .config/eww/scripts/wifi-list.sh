#!/usr/bin/env bash
# wifi-list.sh — Output WiFi network list as JSON for eww
# Usage: wifi-list.sh         → list available networks
#        wifi-list.sh rescan  → trigger rescan first

[[ "${1}" == "rescan" ]] && nmcli device wifi rescan 2>/dev/null; sleep 1

nmcli -t -f SSID,SIGNAL,ACTIVE,SECURITY device wifi list 2>/dev/null \
    | grep -v '^--' \
    | sort -t: -k2 -rn \
    | head -20 \
    | while IFS=: read -r ssid signal active security; do
        ssid="${ssid//\\/\\\\}"
        ssid="${ssid//\"/\\\"}"
        connected="false"
        [[ "$active" == "yes" ]] && connected="true"
        secured="false"
        [[ -n "$security" && "$security" != "--" ]] && secured="true"

        # Signal to bars icon
        if   [[ $signal -ge 80 ]]; then icon="󰤨"
        elif [[ $signal -ge 60 ]]; then icon="󰤥"
        elif [[ $signal -ge 40 ]]; then icon="󰤢"
        elif [[ $signal -ge 20 ]]; then icon="󰤟"
        else                            icon="󰤯"
        fi

        printf '{"ssid":"%s","signal":%s,"signal_pct":"%s%%","connected":%s,"secured":%s,"icon":"%s"}\n' \
            "$ssid" "$signal" "$signal" "$connected" "$secured" "$icon"
    done \
    | jq -s '.'
