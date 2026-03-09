#!/usr/bin/env bash
# battery-info.sh — Battery status JSON for eww battery popup
# Output: {"percent": 85, "status": "Discharging", "time_remaining": "3:42", "icon": ""}

# Auto-detect battery device (handles BAT0, BAT1, etc.)
BAT_DEVICE=$(upower -e 2>/dev/null | grep battery | head -1)
UPOWER_OUT=""
if [[ -n "$BAT_DEVICE" ]]; then
    UPOWER_OUT=$(upower -i "$BAT_DEVICE" 2>/dev/null)
fi

if [[ -z "$UPOWER_OUT" ]]; then
    printf '{"percent":0,"status":"Unknown","time_remaining":"--","icon":"󰂎"}\n'
    exit 0
fi

percent=$(echo "$UPOWER_OUT" | grep "percentage:" | awk '{print int($2)}')
status=$(echo "$UPOWER_OUT"  | grep "state:"      | awk '{print $2}')
time=$(echo "$UPOWER_OUT"    | grep "time to"     | awk '{print $4, $5}' | head -1)

case "$status" in
    charging|"fully-charged")
        if   [[ $percent -ge 90 ]]; then icon="󰂅"
        elif [[ $percent -ge 70 ]]; then icon="󰂋"
        elif [[ $percent -ge 50 ]]; then icon="󰂉"
        elif [[ $percent -ge 30 ]]; then icon="󰂇"
        else                             icon="󰢜"
        fi
        ;;
    *)
        if   [[ $percent -ge 90 ]]; then icon="󰁹"
        elif [[ $percent -ge 70 ]]; then icon="󰂂"
        elif [[ $percent -ge 50 ]]; then icon="󰂀"
        elif [[ $percent -ge 30 ]]; then icon="󰁾"
        elif [[ $percent -ge 15 ]]; then icon="󰁼"
        else                             icon="󰂎"
        fi
        ;;
esac

time="${time:-"--"}"
time="${time//\"/\\\"}"

printf '{"percent":%s,"percent_str":"%s%%","status":"%s","time_remaining":"%s","icon":"%s"}\n' \
    "${percent:-0}" "${percent:-0}" "$status" "$time" "$icon"
