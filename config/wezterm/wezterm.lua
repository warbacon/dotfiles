-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Rendering
-- config.front_end = "WebGpu"

-- Shell
config.default_prog = { "fish" }
-- config.default_prog = { "pwsh", "-NoLogo" }

-- Font
config.font = wezterm.font_with_fallback({ "Fira Code", "Symbols Nerd Font" })
config.font_size = 16
config.unicode_version = 14
config.warn_about_missing_glyphs = false

-- UI
config.color_scheme = "Catppuccin Mocha"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.bold_brightens_ansi_colors = false
config.animation_fps = 1
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_thickness = 3
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false

-- Keymaps
config.keys = {
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

-- and finally, return the configuration to wezterm
return config
