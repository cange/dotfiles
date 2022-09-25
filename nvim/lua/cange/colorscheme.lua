local function variation_by_day_time()
  local h = tonumber(vim.fn.strftime('%k', vim.fn.localtime()))
  local dark = h >= 8 and h <= 18 and 'nordfox' or 'terafox'
  -- local light = h >= 8 and h <= 12 and 'dayfox' or 'dawnfox'
  -- local variation= h >= 11 and  dark or light
  return dark
end

---Provdes meta information of the current colorscheme
local M = {}

M.theme = 'nightfox'
M.variation = variation_by_day_time()

---Color palette of current used colorscheme.
-- @return table<string, string>
M.palette = function()
  local found_palette, palette = pcall(require, M.theme .. '.palette')
  if not found_palette then
    print('colorscheme: "' .. M.theme .. '.palette" not found')
    return
  end

  return palette.load(M.variation)
end

return M
