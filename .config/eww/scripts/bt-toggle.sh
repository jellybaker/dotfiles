#!/usr/bin/env bash
# bt-toggle.sh — Bluetooth device connect/disconnect/power toggle
# Usage: bt-toggle.sh power              → toggle BT adapter on/off
#        bt-toggle.sh connect    <mac>   → connect device
#        bt-toggle.sh disconnect <mac>   → disconnect device
#        bt-toggle.sh status             → JSON status

case "$1" in
    power)
        state=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
        if [[ "$state" == "yes" ]]; then
            bluetoothctl power off
        else
            bluetoothctl power on
        fi
        ;;
    connect)
        bluetoothctl connect "$2" 2>&1
        ;;
    disconnect)
        bluetoothctl disconnect "$2" 2>&1
        ;;
    status)
        powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
        enabled="false"
        [[ "$powered" == "yes" ]] && enabled="true"
        printf '{"enabled":%s}\n' "$enabled"
        ;;
esac
