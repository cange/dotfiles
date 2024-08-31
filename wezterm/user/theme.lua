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
local begin_icon = require("wezterm").nerdfonts.ple_left_half_circle_thick
local end_icon = require("wezterm").nerdfonts.ple_right_half_circle_thick

---@param color string
---@param accent string
---@param factor? number
---@return string
local function blend(color, accent, factor) return Color(color):blend(Color(accent), factor or 0.5):to_css() end

---@param name string
---@param active boolean
---@return string, string # accent, fg
local function color_by_dirname(name, active)
  local pal = M.pal
  local names = {
    ["vue"] = "#42b883",
    ["frontend"] = "#f7df1e",
  }
  local bg = pal.bg4
  local fg = active and pal.fg2 or pal.bg0
  for p, accent in pairs(names) do
    if name:find(p) then return blend(bg, accent, 0.3), fg end
  end
  return bg, fg
end

---@param content string
---@param index number
---@param active boolean
function M.render_tab(content, index, active)
  local accent, fg = color_by_dirname(content, active)

  return require("wezterm").format({
    -- start
    { Background = { Color = M.transparent } },
    { Foreground = { Color = accent } },
    { Text = begin_icon },
    --- content
    { Background = { Color = accent } },
    { Foreground = { Color = fg } },
    { Text = string.format("%s %s", index, content) },
    -- end
    { Background = { Color = M.transparent } },
    { Foreground = { Color = accent } },
    { Text = end_icon },
  })
end

return M
