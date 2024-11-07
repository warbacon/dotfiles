local wezterm = require("wezterm")

local M = {
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
	table.insert(M, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return M
