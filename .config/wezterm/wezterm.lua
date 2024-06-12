local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

-- style
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Catppuccin Mocha"
config.font_size = 10.0
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.75
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
