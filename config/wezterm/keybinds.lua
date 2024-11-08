local wezterm = require("wezterm")
local action = require("wezterm").action

local M = {}

M.keys = {
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
		}),
	},
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = action.SpawnTab("CurrentPaneDomain")
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
}

for i = 1, 9 do
	table.insert(M.keys, {
		key = tostring(i),
		mods = "ALT",
		action = action.ActivateTab(i - 1),
	})
end

return M
