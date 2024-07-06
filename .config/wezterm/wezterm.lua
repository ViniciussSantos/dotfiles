local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

local function is_laptop()
  local battery_path = "/sys/class/power_supply/"
  local handle = io.popen("ls " .. battery_path)
  local result = handle:read("*a")
  handle:close()

  if result:match("BAT%d") then
    return true
  else
    return false
  end
end
-- style
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Mocha"
config.font_size = is_laptop() and 12.0 or 10.0
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
