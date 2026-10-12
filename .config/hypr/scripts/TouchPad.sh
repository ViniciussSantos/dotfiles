#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For disabling touchpad.
# Edit the Touchpad_Device on ~/.config/hypr/UserConfigs/Laptops.lua according to your system
# use hyprctl devices to get your system touchpad device name
# source https://github.com/hyprwm/Hyprland/discussions/4283?sort=new#discussioncomment-8648109

notif="$HOME/.config/swaync/images/bell.png"

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"
device=$(grep -oP '^local Touchpad_Device = "\K[^"]+' "$HOME/.config/hypr/UserConfigs/Laptops.lua")

enable_touchpad() {
    printf "true" >"$STATUS_FILE"
    notify-send -u low -i $notif  "Enabling touchpad"
    hyprctl eval "hl.device({ name = '$device', enabled = true })"
}

disable_touchpad() {
    printf "false" >"$STATUS_FILE"
    notify-send -u low -i $notif "Disabling touchpad"
    hyprctl eval "hl.device({ name = '$device', enabled = false })"
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
