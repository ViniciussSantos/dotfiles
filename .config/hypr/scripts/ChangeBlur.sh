#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images/bell.png"

hyprctl eval "
if hl.get_config('decoration.blur.passes') == 2 then
    hl.config({ decoration = { blur = { size = 2, passes = 1 } } })
    hl.exec_cmd('notify-send -e -u low -i \"$notif\" \"Less blur\"')
else
    hl.config({ decoration = { blur = { size = 7, passes = 3 } } })
    hl.exec_cmd('notify-send -e -u low -i \"$notif\" \"Normal blur\"')
end
"
