#!/usr/bin/env bash
# media.sh — Playerctl-based media module for waybar with scrolling title.
# Outputs JSON: {"text": "⏸ Artist - Title…", "tooltip": "...", "class": "playing"}
#
# Scrolling: when title > MAX_LEN chars, the text shifts left every INTERVAL seconds.

MAX_LEN=22          # chars before scrolling kicks in
INTERVAL=0.6        # seconds between scroll steps
SEPARATOR=" · "     # separator between loops

declare -A SCROLL_POS=()
LAST_TRACK=""

play_icon=""    # Nerd Font play
pause_icon=""   # Nerd Font pause
stop_icon="⏹"

get_status() {
    playerctl status 2>/dev/null || echo "Stopped"
}

get_meta() {
    local field="$1"
    playerctl metadata "$field" 2>/dev/null | head -1 | tr -d '\n'
}

# Truncate or scroll a string
scroll_text() {
    local text="$1"
    local key="$2"
    local len=${#text}

    if [[ $len -le $MAX_LEN ]]; then
        echo "$text"
        return
    fi

    # Reset position if track changed
    if [[ "$LAST_TRACK" != "$key" ]]; then
        SCROLL_POS[$key]=0
        LAST_TRACK="$key"
    fi

    local loop="${text}${SEPARATOR}"
    local loop_len=${#loop}
    local pos=${SCROLL_POS[$key]:-0}

    # Extract window of MAX_LEN chars from the looping string
    local doubled="${loop}${loop}"
    local window="${doubled:$pos:$MAX_LEN}"

    # Advance position
    SCROLL_POS[$key]=$(( (pos + 1) % loop_len ))

    echo "$window"
}

emit() {
    local status artist title icon display tooltip class

    status=$(get_status)

    case "$status" in
        Playing)  icon="$play_icon";  class="playing" ;;
        Paused)   icon="$pause_icon"; class="paused"  ;;
        Stopped|*)
            printf '{"text": "%s", "class": "stopped", "tooltip": "No media"}\n' "$stop_icon"
            return
            ;;
    esac

    artist=$(get_meta "artist")
    title=$(get_meta "title")
    [[ -z "$title" ]] && title=$(get_meta "xesam:url" | sed 's|.*/||;s|%20| |g')
    [[ -z "$title" ]] && title="Unknown"
    [[ -z "$artist" ]] && artist="Unknown"

    local track_key="${artist}-${title}"
    local scrolled
    scrolled=$(scroll_text "$title" "$track_key")

    # Escape for JSON
    local esc_artist esc_scrolled esc_title
    esc_artist=$(echo "$artist" | sed 's/\\/\\\\/g;s/"/\\"/g')
    esc_scrolled=$(echo "$scrolled" | sed 's/\\/\\\\/g;s/"/\\"/g')
    esc_title=$(echo "$title" | sed 's/\\/\\\\/g;s/"/\\"/g')

    local text="${icon} ${esc_artist} - ${esc_scrolled}"
    local tooltip="${esc_artist} — ${esc_title}\n$(playerctl metadata --format '{{mpris:length}}' 2>/dev/null | awk '{printf "%d:%02d", $1/60000000, ($1%60000000)/1000000}' || echo '')"

    printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' \
        "$text" "$tooltip" "$class"
}

# Main loop
while true; do
    emit
    sleep "$INTERVAL"
done
