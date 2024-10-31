local wezterm = require 'wezterm'
local config = {}

config.window_background_opacity = 0.95
config.color_scheme = 'Dracula'
config.font = wezterm.font 'FantasqueSansM Nerd Font Mono'
-- config.font = wezterm.font 'JetBrains Mono NL'
-- config.font = wezterm.font 'Monaspace Neon'
config.font_size = 14
-- diable ligature
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.initial_rows = 44  -- 24 default
config.initial_cols = 121  -- 80 default
config.hide_tab_bar_if_only_one_tab = true

config.audible_bell = 'Disabled'

-- config.font = wezterm.font('JetBrains MonoNL Nerd Font Mono')

-- config.default_prog = { 'C:\\Windows\\System32\\wsl.exe', '~' }
-- config.default_domain = 'WSL:Ubuntu'

config.keys = {
    -- in combination with PowerToys, WIN+f is again mapped to F11
    -- most browsers mapped F11 to fullscreen too
    {
      key = 'F11',
    --   mods = 'WIN',
      action = wezterm.action.ToggleFullScreen,
    },
  }


return config
