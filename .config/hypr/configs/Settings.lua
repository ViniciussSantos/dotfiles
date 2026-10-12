local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd(home .. "/.config/hypr/initial-boot.sh")
    hl.exec_cmd(home .. "/.config/hypr/UserScripts/fixDolphin.sh")
end)
