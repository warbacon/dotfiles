-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Catppuccin Mocha'

config.default_prog = { 'pwsh', '-NoLogo' }
config.launch_menu = {
  {
    label = 'Powershell',
    args = { 'pwsh', '-NoLogo' },
  },
  {
    label = 'Windows Powershell',
    args = { 'powershell', '-NoLogo' },
  },
  {
    label = 'Símbolo del sistema',
    args = { 'cmd' },
  },
  {
    label = 'Kali Linux',
    args = { 'kali' },
    cwd = "/wsl.localhost/kali-linux"
  },
}

config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
-- config.window_close_confirmation = 'NeverPrompt'

-- config.font_size = 16.0
config.unicode_version = 14
config.font = wezterm.font_with_fallback {
    {
        family = 'JetBrains Mono',
        harfbuzz_features = { 'zero' }
    },
    'Symbols Nerd Font',
    'Segoe UI Emoji'
}

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- config.max_fps = 144

config.initial_cols = 125
config.initial_rows = 30
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config