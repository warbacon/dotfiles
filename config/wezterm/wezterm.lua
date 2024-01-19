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
-- config.default_prog = { "zsh" }
-- config.default_prog = { "pwsh", "-NoLogo" }

-- Font
config.font = wezterm.font_with_fallback({ "Fira Code", "Symbols Nerd Font" })
config.font_size = 16
config.unicode_version = 14
config.warn_about_missing_glyphs = false

-- UI
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

-- Kanagawa
config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

	tab_bar = {
		background = "#16161D",
		active_tab = {
			bg_color = "#1F1F28",
			fg_color = "#DCD7BA",
		},
		inactive_tab = {
			bg_color = "#16161D",
			fg_color = "#C8C093",
		},
		inactive_tab_hover = {
			bg_color = "#2A2A37",
			fg_color = "#C8C093",
			italic = false,
		},
		new_tab = {
			bg_color = "#16161D",
			fg_color = "#C8C093",
		},
		new_tab_hover = {
			bg_color = "#2A2A37",
			fg_color = "#C8C093",
			italic = false,
		},
	},
}

-- and finally, return the configuration to wezterm
return config
