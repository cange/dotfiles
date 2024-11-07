-- inspired by https://alexplescan.com/posts/2024/08/10/wezterm/https://alexplescan.com/posts/2024/08/10/wezterm/
local wezterm = require("wezterm")
local theme = require("user.theme")
local pal = theme.pal
local config = wezterm.config_builder()
local font = wezterm.font({ family = "JetBrainsMono Nerd Font", scale = 1 })
local bg_base = pal.bg0

config = {
  color_scheme = theme.color_scheme,
  scrollback_lines = 10000,

  -- keys
  leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 2000 },
  keys = require("user.keymaps"),
  -- Fonts

  font = font,
  adjust_window_size_when_changing_font_size = false,
  -- Cursor
  default_cursor_style = "BlinkingUnderline",

  -- Background
  macos_window_background_blur = 48,
  window_background_gradient = {
    orientation = "Vertical",
    noise = 40,
    colors = {
      theme.hex2rgba(bg_base, 72),
      theme.hex2rgba(bg_base, 80),
      theme.hex2rgba(bg_base, 96),
    },
  },
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_frame = {
    font = font,
    active_titlebar_bg = theme.transparent,
    inactive_titlebar_bg = pal.bg0,
  },
  inactive_pane_hsb = {
    -- saturation = 0.9,
    -- brightness = 0.6,
  },

  -- Spacing
  window_padding = {
    bottom = 0,
    left = 8,
    right = 8,
    top = 4,
  },

  -- Tabs
  tab_bar_at_bottom = false,
  tab_max_width = 32,
  use_fancy_tab_bar = true,
  colors = {
    tab_bar = {
      -- the actual tabs are handled below
      new_tab = { bg_color = theme.transparent, fg_color = pal.bg1 },
      new_tab_hover = { bg_color = theme.transparent, fg_color = pal.bg1 },
      inactive_tab_edge = theme.transparent,
    },
  },

  -- make wezterm evnironment aware
  set_environment_variables = {
    PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
  },

  -- Command Palette
  command_palette_bg_color = pal.bg0,
  command_palette_fg_color = pal.sel1,
}

local function get_dir_name(path)
  if path == "default" then return path end
  local home_dir = string.format("file://%s", os.getenv("HOME"))
  return path == home_dir and "." or path:gsub("(.*[/\\])(.*)", "%2")
end

local function get_current_working_dir(tab)
  local path = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  return get_dir_name(path.file_path)
end

-- Set tab title to the one that was set via `tab:set_title()`
-- or fall back to the current working directory as a title
wezterm.on("format-tab-title", function(tab)
  local custom_title = tab.tab_title
  local index = tonumber(tab.tab_index) + 1
  local title = get_current_working_dir(tab)
  if custom_title and #custom_title > 0 then title = custom_title end

  return theme.render_tab(title, index, tab.is_active)
end)

-- Status bar
-- Name of the current workspace | Hostname
wezterm.on("update-status", function(window)
  local fmt = " %s  %s  "
  local content = {
    { Background = { Color = theme.transparent } },
    { Foreground = { Color = pal.fg3 } },
    { Text = string.format(fmt, wezterm.nerdfonts.oct_codespaces, get_dir_name(window:active_workspace())) },
    { Text = string.format(fmt, wezterm.nerdfonts.oct_clock, wezterm.strftime("%a, %e. %b %H:%M")) },
  }

  window:set_right_status(wezterm.format(content))
end)

-- Session manager (save/restore)
-- https://github.com/danielcopper/wezterm-session-manager
local ok, session_manager = pcall(require, "wezterm-session-manager/session-manager")
if not ok then
  error("[wezterm-session-manager] not found! Ensure wezterm-session-manager repo is cloned to your runtimepath")
  -- run git clone https://github.com/danielcopper/wezterm-session-manager.git ~/.config/wezterm/wezterm-session-manager
end

wezterm.on("window-config-reloaded", function(win)
  wezterm.log_info("Startup restore session!", win)
  session_manager.restore_state(win)
end)

wezterm.on("save_session", function(win)
  wezterm.log_info("Save session!", win)
  session_manager.save_state(win)
end)

wezterm.on("restore_session", function(win)
  wezterm.log_info("Restore session!", win)
  session_manager.restore_state(win)
end)

return config
