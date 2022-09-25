local found_colorscheme, colorscheme = pcall(require, 'cange.colorscheme')
if not found_colorscheme then
  print('[nightfox] "cange.colorscheme" module not found')
  return
end

-- theme https://github.com/EdenEast/nightfox.nvim#usage
local found, palette = pcall(require, colorscheme.theme .. '.palette')
if not found then
  print('[nightfox] colorscheme "' .. colorscheme.theme .. '.palette" module not found')
  return
end

local found_theme, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme.variation)
if not found_theme then
  print('[nightfox] "' .. colorscheme.variation .. '" of "' .. colorscheme.theme .. '" colorscheme not found!')
  return
end

vim.notify('Theme: "' .. colorscheme.theme .. '" in "' .. colorscheme.variation .. '" variation')
local c = palette.load(colorscheme.variation)
-- vim.pretty_print('color:', c)

-- adjust colors
vim.api.nvim_set_hl(0, 'CursorLine', { bg = nil }) -- disable default c
vim.api.nvim_set_hl(0, 'Folded', { bg = nil, fg = c.bg4 }) -- reduces folding noise

local found_modes, modes = pcall(require, 'modes')
if not found_modes then
  print('[nightfox] "modes" module not found')
  return
end
-- needs to been calld after colorscheme is established
modes.setup()
