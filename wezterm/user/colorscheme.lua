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
if not ok then error("'nightfox.palette' not found! Please symlink the nightfox repo to your runtimepath") end

M.pal = palette.load(M.color_scheme)

M.transparent = util.hex2rgba("#0000000", 0)

return M
