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
local function hl(name, val)
  local ns_id = 0
  return vim.api.nvim_set_hl(ns_id, name, val)
end

hl('CursorLine', { bg = nil }) -- disable default c
hl('Folded', { bg = nil, fg = c.bg4 }) -- reduces folding noise
-- Highlighting relates words under cursor
hl('IlluminatedWordText', { bg = c.bg1 }) -- Default for references if no kind information is available
hl('IlluminatedWordRead', { bg = c.bg2 }) -- for references of kind read
hl('IlluminatedWordWrite', { bg = c.bg2, bold = true }) -- for references of kind write

local found_modes, modes = pcall(require, 'modes')
if not found_modes then
  print('[nightfox] "modes" module not found')
  return
end
-- needs to been calld after colorscheme is established
modes.setup()
