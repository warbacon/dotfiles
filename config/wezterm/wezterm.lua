-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- GENERAL
config.default_prog = { "fish" }
-- config.default_prog = { "pwsh", "-NoLogo" }
-- config.max_fps = 144
config.unicode_version = 14
config.warn_about_missing_glyphs = false
config.launch_menu = {
	{
		label = "zsh",
		args = { "zsh" },
	},
	{
		label = "bash",
		args = { "bash" },
	},
}

-- UI
config.color_scheme = "Catppuccin Mocha"
config.command_palette_fg_color = "#cdd6f4"
config.command_palette_bg_color = "#45475a"
config.font = wezterm.font_with_fallback({
	"Iosevka Term",
	"Symbols Nerd Font",
	"Noto Color Emoji",
})
config.font_size = 15.16
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 999
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab)
	local title = tab_title(tab)
	local index = tab.tab_index
	if tab.is_active then
		return {
			{ Attribute = { Italic = true } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = "  " .. index + 1 .. ":" .. title .. "  " },
		}
	end
	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Text = "  " .. index + 1 .. ":" .. title .. "  " },
	}
end)

-- KEYBINDINGS
config.keys = {
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
