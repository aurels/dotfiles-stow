local wezterm = require 'wezterm'
local config  = wezterm.config_builder()

config.font_size    = 14
config.color_scheme = 'Abernathy'

-- brew install font-meslo-lg-nerd-font
config.font = wezterm.font("MesloLGS Nerd Font Mono")

config.send_composed_key_when_left_alt_is_pressed  = true
config.send_composed_key_when_right_alt_is_pressed = false

config.enable_tab_bar               = true
config.hide_tab_bar_if_only_one_tab = true

-- config.window_background_opacity    = 0.95
config.macos_window_background_blur = 10

config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

local act = wezterm.action

config.keys = {
  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
}

-- config.tab_max_width = 2000

-- function get_max_cols(window)
--   local tab = window:active_tab()
--   local cols = tab:get_size().cols
--   return cols
-- end

-- wezterm.on(
--   'window-config-reloaded',
--   function(window)
--     wezterm.GLOBAL.cols = get_max_cols(window)
--   end
-- )

-- wezterm.on(
--   'window-resized',
--   function(window, pane)
--     wezterm.GLOBAL.cols = get_max_cols(window)
--   end
-- )

-- wezterm.on(
--   'format-tab-title',
--   function(tab, tabs, panes, config, hover, max_width)
--     local title      = tab.active_pane.title
--     local pad_length = (wezterm.GLOBAL.cols // #tabs - #title) // 2

--     if pad_length * 2 + #title > max_width then
--       pad_length = (max_width - #title) // 2
--     end

--     return string.rep(' ', pad_length) .. title .. string.rep(' ', pad_length)
--   end
-- )

wezterm.on('format-window-title',
  function(tab, pane)
    local home = os.getenv("HOME")
    local cwd  = tostring(pane.current_working_dir.file_path):gsub(home .. "/", "")

    return "WezTerm — " .. tostring(cwd)
  end
)

return config
