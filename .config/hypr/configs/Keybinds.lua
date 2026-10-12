local mainMod = "SUPER"
local home = os.getenv("HOME")
-- Default
local scriptsDir = home .. "/.config/hypr/scripts"
-- User
local UserScripts = home .. "/.config/hypr/UserScripts"

local bind = hl.bind
local exec = hl.dsp.exec_cmd

-- Plugins are loaded by hyprpm after the first config pass, so their functions are looked up
-- when the key is pressed instead of when the config is read.
local function smw(fn, arg)
    return function()
        local plugin = hl.plugin.split_monitor_workspaces
        if plugin ~= nil then
            return plugin[fn](arg)
        end
    end
end

-- Replacement for the removed `workspaceopt allfloat`: float every window on the active
-- workspace, or tile them all back if they're already floating.
local function toggle_all_float()
    local workspace = hl.get_active_workspace()
    if workspace == nil then
        return
    end
    local windows = hl.get_workspace_windows(workspace)
    local action = "unset"
    for _, w in ipairs(windows) do
        if not w.floating then
            action = "set"
            break
        end
    end
    for _, w in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ window = w, action = action }))
    end
end

bind("CTRL + ALT + Delete", hl.dsp.exit())
bind(mainMod .. " + Q", hl.dsp.window.close())
bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind(mainMod .. " + SHIFT + Q", exec(scriptsDir .. "/KillActiveProcess.sh"))
bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + ALT + F", toggle_all_float)
bind("CTRL + ALT + L", exec(scriptsDir .. "/LockScreen.sh"))
bind("CTRL + ALT + P", exec(scriptsDir .. "/Wlogout.sh"))

-- FEATURES / EXTRAS
bind(mainMod .. " + H", exec(scriptsDir .. "/KeyHints.sh")) -- Small help file
bind(mainMod .. " + ALT + R", exec(scriptsDir .. "/Refresh.sh")) -- Refresh waybar, swaync, rofi
bind(mainMod .. " + ALT + E", exec(scriptsDir .. "/RofiEmoji.sh")) -- emoji
bind(mainMod .. " + S", exec(scriptsDir .. "/RofiSearch.sh")) -- Google search from Rofi
bind(mainMod .. " + SHIFT + B", exec(scriptsDir .. "/ChangeBlur.sh")) -- Toggle blur settings
bind(mainMod .. " + SHIFT + G", exec(scriptsDir .. "/GameMode.sh")) -- animations ON/OFF
bind(mainMod .. " + ALT + L", exec(scriptsDir .. "/ChangeLayout.sh")) -- Toggle Master or Dwindle Layout
bind(mainMod .. " + ALT + V", exec(scriptsDir .. "/ClipManager.sh")) -- Clipboard Manager
bind(mainMod .. " + SHIFT + N", exec("swaync-client -t -sw")) -- swayNC panel

-- FEATURES / EXTRAS (UserScripts)
bind(mainMod .. " + W", exec(UserScripts .. "/WallpaperSelect.sh")) -- Select wallpaper to apply
bind(mainMod .. " + SHIFT + W", exec(UserScripts .. "/WallpaperEffects.sh")) -- Wallpaper Effects by imagemagick
bind("CTRL + ALT + W", exec(UserScripts .. "/WallpaperRandom.sh")) -- Random wallpapers

-- Waybar / Bar related
bind(mainMod .. " + B", exec("killall -SIGUSR1 waybar")) -- Toggle hide/show waybar

-- Layout messages only go to the layout that understands them, otherwise Lua pops an error
-- (SUPER + J is shared with hyprexpo below)
local function layoutmsg(layout, msg)
    return function()
        if hl.get_config("general.layout") == layout then
            hl.dispatch(hl.dsp.layout(msg))
        end
    end
end

-- Master Layout
bind(mainMod .. " + CTRL + D", layoutmsg("master", "removemaster"))
bind(mainMod .. " + I", layoutmsg("master", "addmaster"))
bind(mainMod .. " + J", layoutmsg("master", "cyclenext"))
bind(mainMod .. " + K", layoutmsg("master", "cycleprev"))
bind(mainMod .. " + M", layoutmsg("dwindle", "splitratio 0.3"))
bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
bind(mainMod .. " + CTRL + Return", layoutmsg("master", "swapwithmaster"))

-- group
bind(mainMod .. " + G", hl.dsp.group.toggle())
bind(mainMod .. " + SHIFT + tab", hl.dsp.group.next()) -- change focus to another window

-- Cycle windows if floating bring to top
bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Special Keys / Hot Keys
bind("xf86audioraisevolume", exec(scriptsDir .. "/Volume.sh --inc"), { locked = true, repeating = true }) -- volume up
bind("xf86audiolowervolume", exec(scriptsDir .. "/Volume.sh --dec"), { locked = true, repeating = true }) -- volume down
bind("xf86AudioMicMute", exec(scriptsDir .. "/Volume.sh --toggle-mic"), { locked = true }) -- mute mic
bind("xf86audiomute", exec(scriptsDir .. "/Volume.sh --toggle"), { locked = true })
bind("xf86Sleep", exec("systemctl suspend"), { locked = true }) -- sleep button
bind("xf86Rfkill", exec(scriptsDir .. "/AirplaneMode.sh"), { locked = true }) -- Airplane mode

-- media controls using keyboards
bind("xf86AudioPause", exec(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
bind("xf86AudioPlay", exec(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
bind("xf86AudioNext", exec(scriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
bind("xf86AudioPrev", exec(scriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
bind("xf86audiostop", exec(scriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Screenshot keybindings NOTE: You may need to press Fn key as well
bind(mainMod .. " + Print", exec(scriptsDir .. "/ScreenShot.sh --now"))
bind(mainMod .. " + SHIFT + Print", exec(scriptsDir .. "/ScreenShot.sh --area"))
bind(mainMod .. " + CTRL + Print", exec(scriptsDir .. "/ScreenShot.sh --in5")) -- screenshot in 5 secs
bind(mainMod .. " + CTRL + SHIFT + Print", exec(scriptsDir .. "/ScreenShot.sh --in10")) -- screenshot in 10 secs
bind("ALT + Print", exec(scriptsDir .. "/ScreenShot.sh --active")) -- take screenshot of active window

-- screenshot with swappy (another screenshot tool)
bind(mainMod .. " + SHIFT + S", exec(scriptsDir .. "/ScreenShot.sh --swappy"))

-- Resize windows
bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move windows
bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

-- Move focus with mainMod + arrow keys
bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces related
bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "m+1" }))
bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace
bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("special"))

-- split-monitor-workspaces
if hl.plugin.split_monitor_workspaces ~= nil then
    hl.config({
        plugin = {
            split_monitor_workspaces = {
                count = 9,
                keep_focused = 1,
                enable_notifications = 0,
                enable_persistent_workspaces = 1,
            },
        },
    })
end

-- The following mappings use the key codes to better support various keyboard layouts
-- 1 is code:10, 2 is code:11, etc
for i = 1, 10 do
    local key = "code:" .. (i + 9)
    -- Switch workspaces with mainMod + [0-9]
    bind(mainMod .. " + " .. key, smw("workspace", tostring(i)))
    -- Move active window and follow to workspace mainMod + SHIFT [0-9]
    bind(mainMod .. " + SHIFT + " .. key, smw("move_to_workspace", tostring(i)))
    -- Move active window to a workspace silently mainMod + CTRL [0-9]
    bind(mainMod .. " + CTRL + " .. key, smw("move_to_workspace_silent", tostring(i)))
end
bind(mainMod .. " + SHIFT + bracketleft", smw("move_to_workspace", "-1")) -- brackets [ or ]
bind(mainMod .. " + SHIFT + bracketright", smw("move_to_workspace", "+1"))
bind(mainMod .. " + CTRL + bracketleft", smw("move_to_workspace_silent", "-1")) -- brackets [ or ]
bind(mainMod .. " + CTRL + bracketright", smw("move_to_workspace_silent", "+1"))

-- Scroll through existing workspaces with mainMod + scroll
bind(mainMod .. " + mouse_down", smw("workspace", "e+1"))
bind(mainMod .. " + mouse_up", smw("workspace", "e-1"))
bind(mainMod .. " + period", smw("workspace", "e+1"))
bind(mainMod .. " + comma", smw("workspace", "e-1"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hyprexpo
bind(mainMod .. " + j", function()
    if hl.plugin.hyprexpo ~= nil then
        return hl.plugin.hyprexpo.expo("toggle")
    end
end)
