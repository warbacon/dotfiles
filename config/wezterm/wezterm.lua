-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- GENERAL
-- config.default_prog = { "fish" }
-- config.front_end = "WebGpu"
config.term = "wezterm"
config.unicode_version = 14
config.warn_about_missing_glyphs = false

-- UI
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Symbols Nerd Font",
	"Noto Color Emoji",
})
config.font_size = 14.5
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
}

-- ALT + number to activate that tab
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
