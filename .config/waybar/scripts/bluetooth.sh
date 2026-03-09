#!/usr/bin/env bash
# bluetooth.sh — Simple bluetooth status for waybar
powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
if [[ "$powered" == "yes" ]]; then
    echo '{"text":"","class":"enabled"}'
else
    echo '{"text":"","class":"disabled"}'
fi
