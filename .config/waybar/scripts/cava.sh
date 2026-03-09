#!/usr/bin/env python3
"""cava.sh — Reliable cava binary reader for waybar. Handles null bytes natively."""
import subprocess, sys, time, json

CAVA_CFG = "/home/kshinpad/.config/cava/waybar.cfg"
BARS = 8
BAR_CHARS = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
FLAT = json.dumps({"text": "▁▁▁▁▁▁▁▁"})

def map_byte(b):
    if b == 0:
        return ' '
    # sqrt curve: amplifies quiet sounds; b=30 → ~44% → bar 3 instead of 0
    normalized = (b / 255.0) ** 0.5
    idx = min(int(normalized * 8) + 1, 8)
    return BAR_CHARS[idx]

while True:
    try:
        proc = subprocess.Popen(
            ['cava', '-p', CAVA_CFG],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL
        )
        while True:
            frame = proc.stdout.read(BARS)
            if not frame or len(frame) < BARS:
                break
            text = ''.join(map_byte(b) for b in frame)
            print(json.dumps({"text": text}), flush=True)
    except Exception:
        pass
    # cava exited — show flat bars, restart after 1s
    print(FLAT, flush=True)
    sys.stdout.flush()
    time.sleep(1)
