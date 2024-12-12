M = {}

local modes = {
  light = "dawnfox",
  dark = "terafox",
}

local wezterm = require("wezterm")
local function is_dark() return wezterm.gui.get_appearance() == "Dark" end

---@param hex string
---@param alpha? number [0 - 0.9, 1 - 100]
---@return string
function M.hex2rgba(hex, alpha)
  local hex_val = hex:gsub("#", "")
  local rgba = {
    r = tonumber("0x" .. hex_val:sub(1, 2)),
    g = tonumber("0x" .. hex_val:sub(3, 4)),
    b = tonumber("0x" .. hex_val:sub(5, 6)),
    a = alpha and (alpha > 1 and alpha / 100 or alpha) or 1,
  }
  return string.format("rgba(%s, %s, %s, %s)", rgba.r, rgba.g, rgba.b, rgba.a)
end

-- dynamic color assign

---Mocks Neovim's API since some endpoints are required by nightfox.nvim
local function neovim_polyfill()
  ---@diagnostic disable-next-line: lowercase-global
  vim = {
    fn = {
      has = function() return false end,
      expand = function(args) return args end,
    },
  }
end
neovim_polyfill()

-- use Neovim's Nightfox theme API by symlinking (see links.prop)
local ok, palette = pcall(require, "nightfox.palette")
if not ok then error("[nightfox.palette] not found! Please symlink the nightfox repo to your runtimepath") end

M.color_scheme = function() return is_dark() and modes.dark or modes.light end
M.pal = palette.load(M.color_scheme())
M.bg_base = is_dark() and M.pal.bg0 or M.pal.white.base
M.transparent = M.hex2rgba("#0000000", 0)

local Color = require("nightfox.lib.color")

---@param color string
---@param accent string
---@param factor? number
---@return string
local function blend(color, accent, factor) return Color(color):blend(Color(accent), factor or 0.5):to_css() end

---@param name string
---@param active boolean
---@return string, string # fg, accent
local function define_accent_color(name, active)
  local pal = M.pal
  local names = {
    vue = "#42b883",
    frontend = "#f7df1e",
    routing = "#f7df1e",
  }
  local fg = pal.bg1
  local accent = pal.sel1
  for pattern, color in pairs(names) do
    if name:find(pattern) then accent = blend(fg, color, active and 1 or 0.5) end
  end
  return fg, accent
end
function M.fetch_palette()
  M.pal = palette.load(M.color_scheme())
  return M.pal
end

---@param content string
---@param index number
---@param active boolean
function M.render_tab(content, index, active)
  -- NOTE: ensure current color scheme palette is loaded
  M.fetch_palette()
  local icons = {
    first = wezterm.nerdfonts.ple_left_half_circle_thick,
    last = wezterm.nerdfonts.ple_right_half_circle_thick,
    dot = "■",
  }

  local fg, accent = define_accent_color(content, active)
  local bg = active and accent or M.transparent
  -- wezterm.log_info("-color_scheme:", M.color_scheme(), "-dark:", is_dark(), "-bg", bg)
  return wezterm.format({
    -- start
    { Background = { Color = M.transparent } },
    { Foreground = { Color = bg } },
    { Text = active and icons.first or " " },
    --- content
    { Background = { Color = bg } },
    { Foreground = { Color = active and fg or accent } },
    { Text = string.format("%s %s", active and icons.dot or index, content) },
    -- end
    { Background = { Color = M.transparent } },
    { Foreground = { Color = bg } },
    { Text = active and icons.last or " " },
  })
end

return M
