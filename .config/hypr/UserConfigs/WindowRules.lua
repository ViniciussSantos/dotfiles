local rule = hl.window_rule

-- Some samples on how to start apps on specific workspaces
-- rule({ match = { tag = "email*" }, workspace = "1" })
-- rule({ match = { tag = "browser*" }, workspace = "2" })
-- rule({ match = { tag = "projects*" }, workspace = "3" })
-- rule({ match = { tag = "screenshare*" }, workspace = "4 silent" })
-- rule({ match = { tag = "gamestore*" }, workspace = "5" })
-- rule({ match = { class = "^(virt-manager)$" }, workspace = "6 silent" })
-- rule({ match = { class = "^(.virt-manager-wrapped)$" }, workspace = "6 silent" })
-- rule({ match = { tag = "im*" }, workspace = "7" })
-- rule({ match = { class = "obsidian" }, workspace = "8" })
-- rule({ match = { tag = "games*" }, workspace = "8" })
-- rule({ match = { tag = "multimedia*" }, workspace = "9 silent" })

-- TAGS - add apps under appropriate tag to use the same settings
local function tag_class(class, tag)
    rule({ match = { class = class }, tag = "+" .. tag })
end

local function tag_title(title, tag)
    rule({ match = { title = title }, tag = "+" .. tag })
end

-- browser tags
tag_class("^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$", "browser")
tag_class("^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$", "browser")
tag_class("^(chrome-.+-Default)$", "browser")
tag_class("^([Cc]hromium)$", "browser")
tag_class("^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$", "browser")
tag_class("^(Brave-browser(-beta|-dev|-unstable)?)$", "browser")
tag_class("^([Tt]horium-browser|[Cc]achy-browser)$", "browser")
tag_class("^(zen-alpha|zen)$", "browser")

-- notif tags
tag_class("^(swaync-control-center|swaync-notification-window|swaync-client|class)$", "notif")

-- terminal tags
tag_class("^(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty)$", "terminal")

-- email tags
tag_class("^([Tt]hunderbird|org.mozilla.Thunderbird)$", "email")
tag_class("^(eu.betterbird.Betterbird)$", "email")
tag_class("^(org.gnome.Evolution)$", "email")

-- project tags
tag_class("^(codium|codium-url-handler|VSCodium)$", "projects")
tag_class("^(VSCode|code|code-url-handler)$", "projects")
tag_class("^(jetbrains-.+)$", "projects")
tag_class("^(dev.zed.Zed|antigravity)$", "projects")

-- screenshare tags
tag_class("^(com.obsproject.Studio)$", "screenshare")

-- IM tags
tag_class("^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$", "im")
tag_class("^([Ff]erdium)$", "im")
tag_class("^([Ww]hatsapp-for-linux)$", "im")
tag_class("^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$", "im")
tag_class("^(teams-for-linux)$", "im")
tag_class("^(im.riot.Riot|Element)$", "im")

-- game tags
tag_class("^(gamescope)$", "games")
tag_class([[^(steam_app_\d+)$]], "games")

-- gamestore tags
tag_class("^([Ss]team)$", "gamestore")
tag_title("^([Ll]utris)$", "gamestore")
tag_class("^(com.heroicgameslauncher.hgl)$", "gamestore")

-- file-manager tags
tag_class("^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$", "file-manager")
tag_class("^(app.drey.Warp)$", "file-manager")

-- wallpaper tags
tag_class("^([Ww]aytrogen)$", "wallpaper")

-- multimedia tags
tag_class("^([Aa]udacious)$", "multimedia")

-- multimedia-video tags
tag_class("^([Mm]pv|vlc)$", "multimedia_video")

-- settings tags
tag_title("^(ROG Control)$", "settings")
tag_class("^(wihotspot(-gui)?)$", "settings")
tag_class("^([Bb]aobab|org.gnome.[Bb]aobab)$", "settings")
tag_class("^(gnome-disks|wihotspot(-gui)?)$", "settings")
tag_title("(Kvantum Manager)", "settings")
tag_class("^(file-roller|org.gnome.FileRoller)$", "settings")
tag_class("^(nm-applet|nm-connection-editor|blueman-manager)$", "settings")
tag_class("^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$", "settings")
tag_class("^(qt5ct|qt6ct)$", "settings")
tag_class("(xdg-desktop-portal-gtk)", "settings")
tag_class("^(org.kde.polkit-kde-authentication-agent-1)$", "settings")
tag_class("^([Rr]ofi)$", "settings")
tag_class("^(btrfs-assistant)$", "settings")
tag_class("^(timeshift-gtk)$", "settings")

-- viewer tags
tag_class("^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$", "viewer")
tag_class("^(evince)$", "viewer")
tag_class("^(eog|org.gnome.Loupe)$", "viewer")

-- Some special override rules
rule({ match = { tag = "multimedia_video" }, no_blur = true, opacity = "1.0" })
rule({ match = { tag = "multimedia" }, no_blur = true, opacity = "1.0" })

-- POSITION
rule({ match = { title = "^(ROG Control)$" }, center = true })
rule({ match = { title = "^(Keybindings)$" }, center = true })
rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
rule({ match = { class = "^([Ff]erdium)$" }, center = true })

-- windowrule to avoid idle for fullscreen apps
rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- FLOAT
rule({ match = { tag = "wallpaper" }, float = true, center = true })
rule({ match = { tag = "settings" }, float = true, center = true })
rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)" }, float = true })
rule({ match = { class = "(org.gnome.Calculator|qalculate-gtk)" }, float = true })
rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" }, float = true })
rule({ match = { class = "^([Qq]alculate-gtk)$" }, float = true })
rule({ match = { class = "^([Ff]erdium)$" }, float = true })

-- popups and dialogue
local dialog_size = { "(monitor_w*0.7)", "(monitor_h*0.6)" }
rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
rule({ match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" }, float = true })
rule({ match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" }, float = true })
rule({ match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, float = true })
rule({ match = { title = "^(Add Folder to Workspace)$" }, float = true, size = dialog_size, center = true })
rule({ match = { title = "^(Save As)$" }, float = true, size = dialog_size, center = true })
rule({ match = { initial_title = "(Open Files)" }, float = true, size = dialog_size })
rule({ match = { title = "^(SDDM Background)$" }, float = true, center = true, size = { "(monitor_w*0.16)", "(monitor_h*0.12)" } })
rule({ match = { class = "^(yad)$" }, float = true, center = true, size = { "(monitor_w*0.2)", "(monitor_h*0.2)" } })

-- OPACITY
-- rule({ match = { tag = "browser" }, opacity = "0.99 0.8" })
-- rule({ match = { tag = "projects" }, opacity = "0.9 0.8" })
-- rule({ match = { tag = "im" }, opacity = "0.94 0.86" })
-- rule({ match = { tag = "multimedia" }, opacity = "0.94 0.86" })
-- rule({ match = { tag = "file-manager" }, opacity = "0.9 0.8" })
-- rule({ match = { tag = "terminal" }, opacity = "0.9 0.7" })
-- rule({ match = { tag = "settings" }, opacity = "0.8 0.7" })
-- rule({ match = { tag = "viewer" }, opacity = "0.82 0.75" })
-- rule({ match = { tag = "wallpaper" }, opacity = "0.9 0.7" })
-- rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
-- rule({ match = { class = "^(deluge)$" }, opacity = "0.9 0.8" })
-- rule({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" })
-- rule({ match = { title = "^(Picture-in-Picture)$" }, opacity = "0.95 0.75" })

-- SIZE
rule({ match = { tag = "wallpaper" }, size = { "(monitor_w*0.7)", "(monitor_h*0.7)" } })
rule({ match = { tag = "settings" }, size = { "(monitor_w*0.7)", "(monitor_h*0.7)" } })
rule({ match = { class = "^([Ff]erdium)$" }, size = { "(monitor_w*0.6)", "(monitor_h*0.7)" } })
