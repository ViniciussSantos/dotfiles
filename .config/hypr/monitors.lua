-- Personal monitor layout.
--
-- The desktop outputs keep their physical left-to-right arrangement. Rules for
-- outputs that are not connected are ignored by Hyprland. The generic fallback
-- makes laptop-only and previously unseen external-display combinations usable.

hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60.0",   position = "3840x0", scale = 1.0 })
hl.monitor({ output = "DP-1",     mode = "1920x1080@119.98", position = "1920x0", scale = 1.0 })
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@120.0",  position = "0x0",    scale = 1.0 })
hl.monitor({ output = "eDP-1",    mode = "preferred",        position = "auto",   scale = 1 })
hl.monitor({ output = "",         mode = "preferred",        position = "auto",   scale = 1 })
