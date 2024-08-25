local util = require("user.util")
M = {}

-- dynamic color assignment
M.color_scheme = util.is_dark() and "terafox" or "dayfox"

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
M.transparent = util.hex2rgba("#0000000", 0)

local Color = require("nightfox.lib.color")
local begin_icon = require("wezterm").nerdfonts.ple_left_half_circle_thick
local end_icon = require("wezterm").nerdfonts.ple_right_half_circle_thick

---@param name string
---@return string, string # accent, fg
local function colors_by_dirname(name, active)
  local pal = M.pal
  local names = {
    ["vue"] = "#42b883",
    ["frontend"] = "#f7df1e",
  }
  local accent = pal.sel1
  local fg = active and pal.fg1 or pal.bg1
  for p, color in pairs(names) do
    if name:find(p) then return Color(color):blend(Color(accent), 0.8):to_css(), fg end
  end
  return accent, fg
end

---@param content string
---@param index number
---@param active boolean
function M.render_tab(content, index, active)
  local accent, fg = colors_by_dirname(content, active)

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
