-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- This is where you put your own keybinds. Be mindful to check ~/.config/hypr/configs/Keybinds.lua as well to avoid conflicts
-- See also Laptops.lua for laptops keybinds

local mainMod = "SUPER"
local files = "dolphin"
local term = "ghostty"
local browser = "firefox"
local home = os.getenv("HOME")
local scriptsDir = home .. "/.config/hypr/scripts"
local UserScripts = home .. "/.config/hypr/UserScripts"
local exec = hl.dsp.exec_cmd

-- rofi App launcher
-- hl.bind("SUPER_L", exec("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"), { release = true }) -- Super Key to Launch rofi menu
hl.bind(mainMod .. " + D", exec("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"))

hl.bind("CTRL + ALT + T", exec(term)) -- Launch terminal
hl.bind(mainMod .. " + Return", exec(term)) -- Launch terminal

hl.bind(mainMod .. " + T", exec(files)) -- Launch file manager

hl.bind(mainMod .. " + ALT + C", exec(UserScripts .. "/RofiCalc.sh")) -- calculator (qalculate)

-- User Added Keybinds
hl.bind("ALT + Shift_L", exec(scriptsDir .. "/SwitchKeyboardLayout.sh"), { non_consuming = true }) -- Changing the keyboard layout

-- firefox
hl.bind(mainMod .. " + O", exec(browser))

-- For passthrough keyboard into a VM
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("passthru"))
-- hl.define_submap("passthru", function()
--     -- to unbind
--     hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("reset"))
-- end)
