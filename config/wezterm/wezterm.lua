local wezterm = require("wezterm")
local utils = require("utils")

local config = wezterm.config_builder()

-- KEYBINDS
utils.tableMerge(config, require("keybinds"))

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

-- APPEARANCE
config.color_scheme = "tokyonight_night"
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

-- LAUNCH MENU
config.launch_menu = {}

if utils.command_exists("pwsh") then
	table.insert(config.launch_menu, {
		label = "PoweShell",
		args = { "pwsh", "-NoLogo" },
	})
end

if utils.is_win then
	utils.tableMerge(config.launch_menu, {
		{ label = "Windows PowerShell", args = { "powershell", "-NoLogo" } },
		{ label = "Símbolo del sistema", args = { "cmd" } },
	})
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

-- WINDOWS-PC
if utils.hostname == "windows-pc" then
	config.max_fps = 144
	config.font_size = 17
	config.initial_cols = 100
	config.initial_rows = 27

	local wsl_domains = wezterm.default_wsl_domains()
	for _, dom in ipairs(wsl_domains) do
		if dom.name == "WSL:Arch" then
			dom.default_prog = { "/home/warbacon/.local/bin/fish" }
		end
	end
	config.wsl_domains = wsl_domains
end

return config
