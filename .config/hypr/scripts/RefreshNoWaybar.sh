#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# Modified version of Refresh but no waybar refresh
# Used by automatic wallpaper change
# Modified inorder to refresh rofi background, Wallust, SwayNC

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Kill already running processes
_ps=(rofi)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# Wallust refresh
"${SCRIPTSDIR}/WallustSwww.sh" >/dev/null 2>&1 &
exit 0
