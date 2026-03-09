#!/usr/bin/env bash
# Waybar icon-only bluetooth status
# Uses sysfs (world-readable) — no bluetooth group needed for status.
# Full device management (connect/disconnect) still needs: sudo usermod -aG bluetooth $USER

HCI="/sys/class/bluetooth/hci0"

if [[ ! -d "$HCI" ]]; then
    printf '{"text":"󰂲","class":"unavailable","tooltip":"No BT hardware"}\n'
    exit 0
fi

# rfkill state: 1 = unblocked (enabled), 0 = blocked (disabled)
rfkill_state=$(cat "$HCI"/rfkill*/state 2>/dev/null | head -1)
if [[ "$rfkill_state" != "1" ]]; then
    printf '{"text":"󰂲","class":"disabled","tooltip":"Bluetooth off (rfkill)"}\n'
    exit 0
fi

# Try bluetoothctl for connected devices (works if in bluetooth group)
connected=$(bluetoothctl devices Connected 2>/dev/null | grep -v '^No default' | grep '^Device' | head -1)
if [[ -n "$connected" ]]; then
    name=$(echo "$connected" | cut -d' ' -f3-)
    printf '{"text":"󰂱","class":"connected","tooltip":"Connected: %s"}\n' "$name"
else
    printf '{"text":"","class":"enabled","tooltip":"Bluetooth on"}\n'
fi
