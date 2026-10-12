-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Environment variables. See https://wiki.hypr.land/Configuring/Core/Environment-variables/

hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- qt5ct and qt6ct were also set here before, but the last one always won
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- xwayland apps scale fix (useful if you are use monitor scaling)
-- see https://wiki.hypr.land/Configuring/Extra/XWayland/
-- toolkit-specific scale
-- hl.env("GDK_SCALE", "2")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- electron >28 apps (may help)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- fixes the empty "open with" in Dolphin in Hyprland
hl.env("XDG_MENU_PREFIX", "arch-")
