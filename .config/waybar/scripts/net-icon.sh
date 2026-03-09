#!/usr/bin/env bash
# Waybar icon-only network status

wifi_icon() {
    local sig=$1
    if   [[ $sig -ge 75 ]]; then echo "󰤨"
    elif [[ $sig -ge 50 ]]; then echo "󰤥"
    elif [[ $sig -ge 25 ]]; then echo "󰤢"
    else echo "󰤟"; fi
}

state=$(nmcli radio wifi 2>/dev/null)
if [[ "$state" != "enabled" ]]; then
    printf '{"text":"󰤮","class":"disabled","tooltip":"WiFi off"}\n'
    exit 0
fi

ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2}')
if [[ -n "$ssid" ]]; then
    sig=$(nmcli -t -f active,signal dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2}' | head -1)
    icon=$(wifi_icon "${sig:-50}")
    printf '{"text":"%s","class":"connected","tooltip":"%s (%s%%)"}\n' "$icon" "$ssid" "${sig:-?}"
else
    printf '{"text":"󰤮","class":"disconnected","tooltip":"Not connected"}\n'
fi
