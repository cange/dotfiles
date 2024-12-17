M = {}

local modes = {
  light = "dawnfox",
  dark = "terafox",
}

local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
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
M.bg_base = is_dark() and M.pal.bg0 or "#ffffff"
M.transparent = M.hex2rgba("#0000000", 0)

local Color = require("nightfox.lib.color")

---@param color string
---@param accent string
---@param factor? number
---@return string
local function blend(color, accent, factor) return Color(color):blend(Color(accent), factor or 0.5):to_css() end

---@param name string
---@return string, string, string # base, accent, icon
local function define_accent_color(name)
  local pal = M.pal
  local presets = {
    ["#f0db4f"] = { "request", "routing", "tracking", { icon = nf.md_language_javascript } },
    ["#42b883"] = { "vue", "frontend", { icon = nf.md_vuejs } },
  }

  local base = pal.bg0
  local accent = pal.bg4
  local icon = nf.oct_file_directory_open_fill
  for color, patterns in pairs(presets) do
    for _, pattern in ipairs(patterns) do
      if type(pattern) == "string" and name:find(pattern) then
        accent = blend(base, color, 0.8)
        icon = patterns[#patterns].icon or icon
        break
      end
    end
  end
  return base, accent, icon
end

function M.fetch_palette()
  M.pal = palette.load(M.color_scheme())
  return M.pal
end

---@param content string
---@param index number
---@param active boolean
function M.render_tab(content, index, active)
  -- NOTE: ensure current color scheme pal
  M.fetch_palette()
  local icons = {
    first = nf.ple_left_half_circle_thick,
    last = nf.ple_right_half_circle_thick,
  }

  local contra, accent, icon = define_accent_color(content)
  local bg = active and accent or M.transparent
  -- wezterm.log_info("-color_scheme:", M.color_scheme(), "-dark:", is_dark(), "-bg", bg)
  return wezterm.format({
    -- start
    { Background = { Color = M.transparent } },
    { Foreground = { Color = bg } },
    { Text = active and icons.first or " " },
    --- content
    { Background = { Color = bg } },
    { Foreground = { Color = active and contra or accent } },
    { Text = string.format("%s %s", active and icon or index, content) },
    -- end
    { Background = { Color = M.transparent } },
    { Foreground = { Color = bg } },
    { Text = active and icons.last or " " },
  })
end

return M
