M = {}

local function is_dark() return require("wezterm").gui.get_appearance():find("Dark") end

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

-- dynamic color assignment
M.color_scheme = is_dark() and "terafox" or "dayfox"

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

M.pal = palette.load(M.color_scheme)
M.pal = palette.load("terafox") -- debug only
M.transparent = M.hex2rgba("#0000000", 0)

local Color = require("nightfox.lib.color")
---@param color string
---@param accent string
---@param factor? number
---@return string
local function blend(color, accent, factor) return Color(color):blend(Color(accent), factor or 0.5):to_css() end

---@param name string
---@param active boolean
---@return string # accent
local function define_accent_color(name, active)
  local pal = M.pal
  local names = {
    vue = "#42b883",
    frontend = "#f7df1e",
    routing = "#f7df1e",
  }
  local fg = pal.fg0
  for pattern, accent in pairs(names) do
    if name:find(pattern) then fg = accent end
  end
  return blend(fg, pal.bg4, active and 0.3 or 0.7)
end

---@param content string
---@param index number
---@param active boolean
function M.render_tab(content, index, active)
  local icons = {
    -- begin = require("wezterm").nerdfonts.ple_left_half_circle_thick,
    -- ["end"] = require("wezterm").nerdfonts.ple_right_half_circle_thick,
    dot = "■",
  }

  local accent = define_accent_color(content, active)
  return require("wezterm").format({
    -- start
    { Background = { Color = M.transparent } },
    { Foreground = { Color = accent } },
    -- { Text = icons.begin },
    --- content
    -- { Background = { Color = accent } },
    -- { Foreground = { Color = fg } },
    { Text = string.format(" %s %s", active and icons.dot or index, content) },
    -- end
    -- { Background = { Color = M.transparent } },
    -- { Foreground = { Color = accent } },
    -- { Text = icons.end },
  })
end

return M
