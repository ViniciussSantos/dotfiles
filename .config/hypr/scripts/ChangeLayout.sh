#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for changing Hyprland Layouts (Master or Dwindle) on the fly

notif="$HOME/.config/swaync/images/bell.png"

hyprctl eval "
if hl.get_config('general.layout') == 'master' then
    hl.config({ general = { layout = 'dwindle' } })
    hl.unbind('SUPER + J')
    hl.unbind('SUPER + K')
    hl.bind('SUPER + J', hl.dsp.window.cycle_next())
    hl.bind('SUPER + K', hl.dsp.window.cycle_next({ next = false }))
    hl.bind('SUPER + O', hl.dsp.layout('togglesplit'))
    hl.exec_cmd('notify-send -e -u low -i \"$notif\" \"Dwindle Layout\"')
else
    hl.config({ general = { layout = 'master' } })
    hl.unbind('SUPER + J')
    hl.unbind('SUPER + K')
    hl.unbind('SUPER + O')
    hl.bind('SUPER + J', hl.dsp.layout('cyclenext'))
    hl.bind('SUPER + K', hl.dsp.layout('cycleprev'))
    hl.exec_cmd('notify-send -e -u low -i \"$notif\" \"Master Layout\"')
end
"
