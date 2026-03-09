#!/bin/bash

# Function to query Niri, sort by visual order, and format the x / y string
print_workspaces() {
    niri msg -j workspaces | jq -r '
        sort_by(.idx) |
        length as $total |
        (map(.is_active) | index(true) + 1) as $current |
        "\($current) / \($total)"
    '
}

# Print the initial state when Waybar launches
print_workspaces

# Listen to Niri's live event stream
niri msg event-stream | while read -r event; do
    # Only trigger an update if the event involves a workspace changing
    if [[ "$event" == *"Workspace"* ]]; then
        print_workspaces
    fi
done
