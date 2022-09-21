---Provdes meta information of the current colorscheme
local M = {}

M.theme = 'nightfox'
M.variation = 'terafox'

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
