local wezterm = require 'wezterm'
local config  = wezterm.config_builder()

config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

COLOR_SCHEME     = 'Tokyo Night'
SSH_COLOR_SCHEME = 'Red Alert'

config.font_size    = 13
config.line_height  = 1
config.color_scheme = COLOR_SCHEME

-- brew install font-meslo-lg-nerd-font
config.font = wezterm.font('MesloLGS Nerd Font Mono')

config.send_composed_key_when_left_alt_is_pressed  = true
config.send_composed_key_when_right_alt_is_pressed = false

config.enable_tab_bar               = true
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity    = 0.9
config.macos_window_background_blur = 10

config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

local act = wezterm.action

config.keys = {
  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
}

wezterm.on('format-window-title',
  function(tab, pane)
    local home = os.getenv('HOME')
    local cwd  = tostring(pane.current_working_dir.file_path):gsub(home .. '/', '')

    return "WezTerm — " .. tostring(cwd)
  end
)

wezterm.on('update-status',
  function(window, pane)
    local fg_process_name = pane:get_foreground_process_name()
    local overrides       = window:get_config_overrides() or {}

    if fg_process_name == '/usr/bin/ssh' then
      overrides.color_scheme = SSH_COLOR_SCHEME
    else
      overrides.color_scheme = COLOR_SCHEME
    end

    window:set_config_overrides(overrides)
  end
)

return config
