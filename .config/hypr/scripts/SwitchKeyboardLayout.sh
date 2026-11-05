#!/bin/bash
# Moves every keyboard to the layout after the main keyboard's current one, so they all stay on the same layout.
# Layouts are set in kb_layout in UserConfigs/UserSettings.lua

notif="$HOME/.config/swaync/images/bell.png"

devices=$(hyprctl devices -j)
read -r index count < <(jq -r '.keyboards[] | select(.main) | "\(.active_layout_index) \(.layout | split(",") | length)"' <<< "$devices")

if [ -z "$index" ]; then
    notify-send -u low -t 2000 'Keyboard layout' 'Error: No main keyboard found'
    exit 1
fi

next_index=$(( (index + 1) % count ))
got_error=false

while read -r name; do
    if ! hyprctl switchxkblayout "$name" "$next_index" > /dev/null; then
        >&2 echo "Error while switching the layout for $name."
        got_error=true
    fi
done < <(jq -r '.keyboards[].name' <<< "$devices")

if [ "$got_error" = true ]; then
    notify-send -u low -t 2000 'Keyboard layout' 'Error: Layout change failed'
    exit 1
fi

new_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main) | .active_keymap')
notify-send -u low -i "$notif" "new KB_Layout: $new_layout"
