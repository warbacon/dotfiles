local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows")
local hostname = wezterm.hostname()

---@param command string
local function command_exists(command)
	if is_windows then
		return wezterm.run_child_process({ "where", command })
	else
		return wezterm.run_child_process({ "which", command })
	end
end

-- LAUNCH MENU
config.launch_menu = {}

if command_exists("pwsh") then
	table.insert(config.launch_menu, {
		label = "PoweShell",
		args = { "pwsh", "-NoLogo" },
	})
end

if is_windows then
	for _, entry in ipairs({
		{ label = "Windows PowerShell", args = { "powershell", "-NoLogo" } },
		{ label = "Símbolo del sistema", args = { "cmd" } },
	}) do
		table.insert(config.launch_menu, entry)
	end
else
	if command_exists("fish") then
		table.insert(config.launch_menu, {
			label = "Fish",
			args = { "fish" },
		})
	end
	if command_exists("bash") then
		table.insert(config.launch_menu, {
			label = "Bash",
			args = { "bash" },
		})
	end
	if command_exists("zsh") then
		table.insert(config.launch_menu, {
			label = "Zsh",
			args = { "zsh" },
		})
	end
end

-- BEHAVIOUR
config.default_prog = is_windows and { "pwsh", "-NoLogo" } or command_exists("fish") and { "fish" }

config.adjust_window_size_when_changing_font_size = false

config.switch_to_last_active_tab_when_closing_tab = true
config.mouse_wheel_scrolls_tabs = false

config.warn_about_missing_glyphs = false

config.enable_kitty_keyboard = true

-- APPEARANCE
config.color_scheme = "tokyonight_moon"
config.bold_brightens_ansi_colors = false

config.font_size = 13.3
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Symbols Nerd Font"
})

config.command_palette_fg_color = "#c8d3f5"
config.command_palette_bg_color = "#2f334d"
config.char_select_fg_color = config.command_palette_fg_color
config.char_select_bg_color = config.command_palette_bg_color

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 999

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- PERFORMANCE
config.use_ime = false

config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

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

-- ZENARCH
if hostname == "zenarch" then
	config.window_decorations = "NONE"
end

-- WINDOWS-PC
if hostname == "windows-pc" then
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	config.max_fps = 144
	config.font_size = 20
	config.initial_cols = 100
	config.initial_rows = 25
end

return config
