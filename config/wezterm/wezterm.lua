local wezterm = require("wezterm")
local utils = require("utils")

local config = wezterm.config_builder()

-- KEYBINDS
config.keys = require("keybinds")

-- BEHAVIOUR
if utils.is_win then
	config.default_prog = { "pwsh", "-NoLogo" }
elseif utils.command_exists("fish") then
	config.default_prog = { "fish" }
end

config.adjust_window_size_when_changing_font_size = false

config.switch_to_last_active_tab_when_closing_tab = true
config.mouse_wheel_scrolls_tabs = false

config.warn_about_missing_glyphs = false

config.enable_kitty_keyboard = true

-- APPEARANCE
config.color_scheme = "tokyonight_moon"
config.bold_brightens_ansi_colors = "No"

config.font_size = 13.3
config.font = utils.is_win and wezterm.font_with_fallback({
	"JetBrains Mono",
	"Segoe UI Emoji",
}) or nil

config.command_palette_fg_color = "#c8d3f5"
config.command_palette_bg_color = "#2f334d"
config.char_select_fg_color = config.command_palette_fg_color
config.char_select_bg_color = config.command_palette_bg_color

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 999

-- PERFORMANCE
if utils.is_win then
	for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
		if gpu.backend == "Dx12" then
			config.webgpu_preferred_adapter = gpu
			config.front_end = "WebGpu"
			break
		end
	end
end

-- LAUNCH MENU
config.launch_menu = {}

if utils.command_exists("pwsh") then
	table.insert(config.launch_menu, {
		label = "PoweShell",
		args = { "pwsh", "-NoLogo" },
	})
end

if utils.is_win then
	for _, entry in ipairs({
		{ label = "Windows PowerShell", args = { "powershell", "-NoLogo" } },
		{ label = "Símbolo del sistema", args = { "cmd" } },
	}) do
		table.insert(config.launch_menu, entry)
	end
else
	if utils.command_exists("fish") then
		table.insert(config.launch_menu, {
			label = "Fish",
			args = { "fish" },
		})
	end
	if utils.command_exists("bash") then
		table.insert(config.launch_menu, {
			label = "Bash",
			args = { "bash" },
		})
	end
	if utils.command_exists("zsh") then
		table.insert(config.launch_menu, {
			label = "Zsh",
			args = { "zsh" },
		})
	end
end

-- HOST SPECIFIC
if utils.hostname == "zenarch" then
	config.window_decorations = "NONE"
end
if utils.hostname == "windows-pc" then
	config.max_fps = 144
	config.font_size = 16
	config.initial_cols = 110
	config.initial_rows = 29
end

return config
