---Provdes meta information of the current colorscheme
M = {}

M.theme = 'nightfox'
M.variation = 'terafox'

---Color palette of current used colorscheme.
-- @return table<string, string>
M.palette = function()
  local found_palette, palette = pcall(require, M.theme .. '.palette')
  if not found_palette then
    vim.notify('colorscheme: "' .. M.theme .. '.palette" could not be found')
    return
  end

  return palette.load(M.variation)
end

return M
