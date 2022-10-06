local ns = 'nightfox'
local found_colorscheme, colorscheme = pcall(require, 'cange.colorscheme')
if not found_colorscheme then
  print('[' .. ns .. '] "cange.colorscheme" module not found')
  return
end

-- theme https://github.com/EdenEast/nightfox.nvim#usage
local found, palette = pcall(require, colorscheme.theme .. '.palette')
if not found then
  print('[' .. ns .. '] colorscheme "' .. colorscheme.theme .. '.palette" module not found')
  return
end

local found_theme, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme.variation)
if not found_theme then
  print('[' .. ns .. '] "' .. colorscheme.variation .. '" of "' .. colorscheme.theme .. '" colorscheme not found!')
  return
end

-- vim.notify('Theme: "' .. colorscheme.theme .. '" in "' .. colorscheme.variation .. '" variation')
local c = palette.load(colorscheme.variation)
-- vim.pretty_print('color:', vim.tbl_keys(c))

-- adjust colors
local function hl(name, val)
  local ns_id = 0
  return vim.api.nvim_set_hl(ns_id, name, val)
end

local highlights = {
  -- defaults override
  CursorLine = { bg = nil }, -- disable default
  Folded = { bg = nil, fg = c.bg4 }, -- reduces folding noise
  -- illuminate
  IlluminatedWordText = { bg = c.bg1 }, -- Default for references if no kind information is available
  IlluminatedWordRead = { bg = c.bg2 }, -- for references of kind read
  IlluminatedWordWrite = { bg = c.bg2, bold = true }, -- for references of kind write
}

for name, val in pairs(highlights) do
  -- vim.pretty_print('name', name, 'val', val)
  hl(name, val) -- for references of kind write
end

local found_modes, modes = pcall(require, 'modes')
if not found_modes then
  print('[' .. ns .. '] "modes" module not found')
  return
end
-- needs to been calld after colorscheme is established
modes.setup()
