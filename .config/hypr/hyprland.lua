-- Sourcing external config files
-- Each require runs in its own scope, so an error in one file doesn't stop the others.

-- Default Configs
require("configs.Settings")
require("configs.Keybinds")

-- User Configs
require("UserConfigs.Startup_Apps")
require("UserConfigs.ENVariables")
require("UserConfigs.Laptops")
require("UserConfigs.WindowRules")
require("UserConfigs.UserKeybinds")
require("UserConfigs.UserSettings")

require("monitors")
