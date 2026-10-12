#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations

notif="$HOME/.config/swaync/images/bell.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"


HYPRGAMEMODE=$(hyprctl repl 'hl.get_config("animations.enabled")')
if [ "$HYPRGAMEMODE" = true ] ; then
    hyprctl eval "hl.config({
        animations = { enabled = false },
        decoration = { shadow = { enabled = false }, blur = { passes = 0 }, rounding = 0 },
        general = { gaps_in = 0, gaps_out = 0, border_size = 1 },
    })"
    awww kill
    notify-send -e -u low -i "$notif" "gamemode enabled. All animations off"
    exit
else
	if ! awww query >/dev/null 2>&1; then
		awww-daemon --format xrgb &
		sleep 0.2
	fi
	awww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	"${SCRIPTSDIR}/WallustSwww.sh"
	sleep 0.5
	"${SCRIPTSDIR}/Refresh.sh"
	hyprctl reload
    notify-send -e -u normal -i "$notif" "gamemode disabled. All animations normal"
    exit
fi
