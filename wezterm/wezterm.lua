-- inspired by https://alexplescan.com/posts/2024/08/10/wezterm/https://alexplescan.com/posts/2024/08/10/wezterm/
local wezterm = require("wezterm")
local c = require("user.colorscheme")
local util = require("user.util")
local pal = c.pal
local config = wezterm.config_builder()
local fontFamily = "JetBrainsMono Nerd Font"
local bg_base = pal.bg1
local bg_presets = {
  BLURRY = {
    util.hex2rgba(bg_base, 80),
    util.hex2rgba(pal.bg0, 88),
    util.hex2rgba(pal.bg0, 96),
    bg_base,
  },
  OPAQUE = { bg_base },
}
config = util.tbl_extend("keep", config, {
  keys = require("user.keymaps"),
  color_scheme = c.color_scheme,
  -- Fonts
  font = wezterm.font({ family = fontFamily }),
  font_size = 12,
  line_height = 1.0,
  -- Cursor
  default_cursor_style = "BlinkingUnderline",
  cursor_blink_rate = 600,

  -- Background
  macos_window_background_blur = 48,
  window_background_gradient = {
    orientation = "Vertical",
    noise = 40,
    colors = bg_presets.BLURRY,
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
    font = wezterm.font({ family = fontFamily, weight = "Regular" }),
    font_size = 11,
    active_titlebar_bg = bg_base,
  },
  tab_max_width = 32,
  colors = {
    tab_bar = {
      -- active_tab = { bg_color = transparent, fg_color = pal.yellew.base },
      inactive_tab = { bg_color = c.transparent, fg_color = pal.fg3 },
      inactive_tab_edge = c.transparent,
      new_tab = { bg_color = c.transparent, fg_color = pal.fg3 },
      inactive_tab_hover = { bg_color = c.transparent, fg_color = pal.green.bright },
      new_tab_hover = { bg_color = c.transparent, fg_color = pal.green.bright },
    },
  },
  hide_tab_bar_if_only_one_tab = true,

  -- make wezterm evnironment aware
  set_environment_variables = {
    PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
  },
})

local fmt = string.format
---@param text string
---@param max number
---@return string
local function truncate_mid(text, max)
  return #text > max and fmt("%s…%s", wezterm.truncate_right(text, max / 2), wezterm.truncate_left(text, max / 2))
    or text
end

---@param tab_info table
---@param is_active? boolean
---@return string
local function tab_title(tab_info, is_active)
  local title = tab_info.tab_title
  return title and #title > 0 and title or (is_active and tab_info.active_pane.title or tab_info.window_title)
end

local tab_accent = pal.bg3
local icon_start = wezterm.nerdfonts.ple_left_half_circle_thick
local icon_end = wezterm.nerdfonts.ple_right_half_circle_thick

---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
  if tab.is_active then
    -- DEBUG: enable refresh palette in dev/debug mode since it is inconsistent
    -- pal = require("colorscheme").palette.load(c.color_scheme)
    -- tab_accent = pal.sel0
    local title = tab_title(tab, true)

    return wezterm.format({
      { Background = { Color = c.transparent } },
      { Foreground = { Color = tab_accent } },
      { Text = " " .. icon_start },
      { Background = { Color = tab_accent } },
      { Foreground = { Color = pal.fg2 } },
      { Text = fmt(" %s %s ", tab.tab_index + 1, truncate_mid(title, max_width)) },
      { Background = { Color = c.transparent } },
      { Foreground = { Color = tab_accent } },
      { Text = "" },
      { Text = icon_end },
    })
  else
    local index = tab.tab_index + 1
    local t = #tabs > 1 and tab_title(tabs[index])
    return fmt("  %s %s ", index, truncate_mid(string.match(t or "", "%((.*)%)") or "", max_width))
  end
end)

return config
