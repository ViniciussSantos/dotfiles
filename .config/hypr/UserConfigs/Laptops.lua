-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- These configs are mostly for laptops. This is addendum to Keybinds.lua

local mainMod = "SUPER"
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"
local exec = hl.dsp.exec_cmd
-- for disabling Touchpad. hyprctl devices to get device name.
-- TouchPad.sh reads the name from this line, keep it on one line.
local Touchpad_Device = "asue1209:00-04f3:319f-touchpad"

hl.bind("xf86KbdBrightnessDown", exec(scriptsDir .. "/BrightnessKbd.sh --dec"), { repeating = true }) -- Keyboard brightness Down
hl.bind("xf86KbdBrightnessUp", exec(scriptsDir .. "/BrightnessKbd.sh --inc"), { repeating = true }) -- Keyboard brightness up
hl.bind("xf86Launch1", exec("rog-control-center")) -- ASUS Armory crate button
hl.bind("xf86Launch3", exec("asusctl led-mode -n")) -- FN+F4 Switch keyboard RGB profile
hl.bind("xf86Launch4", exec("asusctl profile -n")) -- FN+F5 change of fan profiles (Quite, Balance, Performance)
hl.bind("xf86MonBrightnessDown", exec(scriptsDir .. "/Brightness.sh --dec"), { repeating = true })
hl.bind("xf86MonBrightnessUp", exec(scriptsDir .. "/Brightness.sh --inc"), { repeating = true })
hl.bind("xf86TouchpadToggle", exec(scriptsDir .. "/TouchPad.sh")) -- disable touchpad

-- Screenshot keybindings for Asus G15 (no PrinSrc button)
hl.bind(mainMod .. " + F6", exec(scriptsDir .. "/ScreenShot.sh --now")) -- Fullscreen
hl.bind(mainMod .. " + SHIFT + F6", exec(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + CTRL + F6", exec(scriptsDir .. "/ScreenShot.sh --in5")) -- Screenshot in 5 secs
hl.bind(mainMod .. " + ALT + F6", exec(scriptsDir .. "/ScreenShot.sh --in10")) -- Screenshot in 10 secs
hl.bind("ALT + F6", exec(scriptsDir .. "/ScreenShot.sh --active")) -- Screenshot active window

-- TouchPad.sh toggles this at runtime with hyprctl eval
hl.device({
    name = Touchpad_Device,
    enabled = true,
})
