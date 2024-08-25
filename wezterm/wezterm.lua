-- inspired by https://alexplescan.com/posts/2024/08/10/wezterm/https://alexplescan.com/posts/2024/08/10/wezterm/
local wezterm = require("wezterm")
local theme = require("user.theme")
local util = require("user.util")
local pal = theme.pal
local config = wezterm.config_builder()
local font = wezterm.font({ family = "JetBrainsMono Nerd Font", scale = 1 })
local bg_base = pal.bg0
local bg_presets = {
  BLURRY = {
    util.hex2rgba(bg_base, 80),
    util.hex2rgba(bg_base, 96),
    util.hex2rgba(bg_base, 96),
  },
  OPAQUE = { bg_base },
}

config = {
  color_scheme = theme.color_scheme,
  scrollback_lines = 10000,

  -- keys
  leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 2000 },
  keys = require("user.keymaps"),
  -- Fonts

  font = font,
  -- Cursor
  default_cursor_style = "BlinkingUnderline",

  -- Background
  macos_window_background_blur = 48,
  window_background_gradient = {
    orientation = "Vertical",
    noise = 40,
    colors = bg_presets.BLURRY,
  },
  inactive_pane_hsb = {
    saturation = 0,
  },

  -- Spacing
  window_padding = {
    bottom = 0,
    left = "0.5cell",
    right = "0.5cell",
    top = "0.5cell",
  },

  -- Tabs
  window_decorations = "RESIZE",
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = true,
  window_frame = {
    font = font,
    active_titlebar_bg = theme.transparent,
    inactive_titlebar_bg = pal.bg0,
  },
  tab_max_width = 32,
  colors = {
    tab_bar = {
      -- the actual tabs are handled below
      new_tab = { bg_color = theme.transparent, fg_color = pal.fg3 },
      new_tab_hover = { bg_color = theme.transparent, fg_color = pal.green.bright },
      inactive_tab_edge = theme.transparent,
    },
  },
  hide_tab_bar_if_only_one_tab = true,

  -- make wezterm evnironment aware
  set_environment_variables = {
    PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
  },

  -- Command Palette
  command_palette_bg_color = pal.bg0,
  command_palette_fg_color = pal.sel1,
}

-- Set tab title to the one that was set via `tab:set_title()`
-- or fall back to the current working directory as a title
wezterm.on("format-tab-title", function(tab)
  local custom_title = tab.tab_title
  local index = tonumber(tab.tab_index) + 1
  local title = util.get_current_working_dir(tab)
  if custom_title and #custom_title > 0 then title = custom_title end

  return theme.render_tab(title, index, tab.is_active)
end)

return config
