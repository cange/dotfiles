-- Pull in the wezterm API
local wezterm = require("wezterm")

---@param hex string
---@param alpha? number
---@return string
local function hex2rgba(hex, alpha)
  local hex_val = hex:gsub("#", "")
  local res = {
    r = tonumber("0x" .. hex_val:sub(1, 2)),
    g = tonumber("0x" .. hex_val:sub(3, 4)),
    b = tonumber("0x" .. hex_val:sub(5, 6)),
    a = alpha or 1,
  }
  return string.format("rgba(%s, %s, %s, %s)", res.r, res.g, res.b, res.a)
end

-- This will hold the configuration.,
local config = wezterm.config_builder()
local colorscheme = "terafox"
---comment
---@param base string
---@param bright string
---@param dim string
---@return table
local function define_shade(base, bright, dim)
  return {
    base = base,
    bright = bright,
    dim = dim,
  }
end

local pal = {
  comment = "#6d7f8b",

  bg0 = "#0f1c1e", -- Dark bg (status line and float)
  bg1 = "#152528", -- Default bg
  bg2 = "#1d3337", -- Lighter bg (colorcolm folds)
  bg3 = "#254147", -- Lighter bg (cursor line)
  bg4 = "#2d4f56", -- Conceal, border fg

  fg0 = "#eaeeee", -- Lighter fg
  fg1 = "#e6eaea", -- Default fg
  fg2 = "#cbd9d8", -- Darker fg (status line)
  fg3 = "#587b7b", -- Darker fg (line numbers, fold colums)

  sel0 = "#293e40", -- Popup bg, visual selection bg
  sel1 = "#425e5e", -- Popup sel bg, search bg

  black = define_shade("#2f3239", "#4e5157", "#282a30"),
  red = define_shade("#e85c51", "#eb746b", "#c54e45"),
  green = define_shade("#7aa4a1", "#8eb2af", "#688b89"),
  yellow = define_shade("#fda47f", "#fdb292", "#d78b6c"),
  blue = define_shade("#5a93aa", "#73a3b7", "#4d7d90"),
  cyan = define_shade("#a1cdd8", "#afd4de", "#89aeb8"),
  white = define_shade("#ebebeb", "#eeeeee", "#c8c8c8"),
  orange = define_shade("#ff8349", "#ff9664", "#d96f3e"),
  magenta = define_shade("#ad5c7c", "#b97490", "#934e69"),
  pink = define_shade("#cb7985", "#d38d97", "#ad6771"),
}
local fontFamily = wezterm.font("JetBrainsMono Nerd Font")
config = {
  color_scheme = colorscheme,
  macos_window_background_blur = 64,
  font = fontFamily,
  window_decorations = "RESIZE",

  -- cursor
  default_cursor_style = "BlinkingUnderline",
  cursor_blink_rate = 400,

  window_background_gradient = {
    orientation = "Vertical",
    colors = {
      hex2rgba(pal.bg1, 0.8),
      hex2rgba(pal.bg0, 0.95),
      pal.bg0, -- 100%
    },
  },
  -- tabs
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = true,
  window_frame = {
    font = fontFamily,
    font_size = 11,
    active_titlebar_bg = pal.bg0,
    inactive_titlebar_bg = pal.sel0,
  },
  colors = {
    tab_bar = {
      background = pal.bg0,
      active_tab = { bg_color = pal.sel0, fg_color = pal.fg2 },
      inactive_tab = { bg_color = pal.bg0, fg_color = pal.fg3 },
      inactive_tab_edge = pal.bg0,
      inactive_tab_hover = { bg_color = pal.bg0, fg_color = pal.fg2 },
      new_tab = { bg_color = pal.bg0, fg_color = pal.fg3 },
      new_tab_hover = { bg_color = pal.bg0, fg_color = pal.fg2 },
    },
  },
  window_padding = {
    left = "2cell",
    right = "2cell",
    top = "0.5cell",
    bottom = 0,
  },
}

-- https://github.com/wez/wezterm/discussions/3426
local function themeCycler(window, _)
  local currentScheme = window:effective_config().color_scheme
  local schemes = { "terafox", "dayfox" }

  for i = 1, #schemes, 1 do
    if schemes[i] == currentScheme then
      local overrides = window:get_config_overrides() or {}
      local next = i % #schemes + 1
      overrides.color_scheme = schemes[next]
      wezterm.log_info("Switched to: " .. schemes[next])
      window:set_config_overrides(overrides)

      -- save the theme to a file so that it can be read by neovim
      wezterm.run_child_process({ "sh", "-c", 'echo "' .. schemes[next] .. '" > /tmp/wez-theme' })
      return
    end
  end
end

local action = wezterm.action

config.keys = {
  { key = "d", mods = "CMD|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CMD", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "Enter", mods = "CMD", action = action.ToggleFullScreen },
  { key = "Enter", mods = "CMD|SHIFT", action = action.TogglePaneZoomState },
  { key = "k", mods = "CMD", action = action.ClearScrollback("ScrollbackAndViewport") },
  { key = "LeftArrow", mods = "CMD", action = action.ClearScrollback("ScrollbackAndViewport") },
  -- Pane sizing
  { key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = action.AdjustPaneSize({ "Left", 1 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = action.AdjustPaneSize({ "Right", 1 }) },
  { key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = action.AdjustPaneSize({ "Up", 1 }) },
  { key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = action.AdjustPaneSize({ "Down", 1 }) },
  -- Pane switching
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Down") },

  { key = "t", mods = "CTRL|SHIFT|ALT", action = wezterm.action_callback(themeCycler) },
}
-- and finally, return the configuration to wezterm
return config
