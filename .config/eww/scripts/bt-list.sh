#!/usr/bin/env bash
# bt-list.sh — Output paired Bluetooth devices as JSON for eww

# Get paired devices
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)
    name="${name//\"/\\\"}"

    # Check if connected
    connected="false"
    info=$(bluetoothctl info "$mac" 2>/dev/null)
    if echo "$info" | grep -q "Connected: yes"; then
        connected="true"
    fi

    # Device type icon (best effort)
    icon=""
    if echo "$info" | grep -qi "audio\|headset\|speaker\|headphone"; then
        icon="󰋋"
    elif echo "$info" | grep -qi "input\|keyboard"; then
        icon="󰌌"
    elif echo "$info" | grep -qi "mouse"; then
        icon="󰍽"
    elif echo "$info" | grep -qi "phone"; then
        icon="󰄜"
    fi

    printf '{"mac":"%s","name":"%s","connected":%s,"icon":"%s"}\n' \
        "$mac" "$name" "$connected" "$icon"
done < <(bluetoothctl devices Paired 2>/dev/null) | jq -s '.'
