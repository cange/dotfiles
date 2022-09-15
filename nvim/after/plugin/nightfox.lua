local found_settings, editor_settings = pcall(require, 'cange.settings.editor')
if not found_settings then
  vim.notify('lualine: "cange.settings.editor" could not be found')
  return
end

-- theme https://github.com/EdenEast/nightfox.nvim#usage
local colorscheme = editor_settings.colorscheme.name
local theme = editor_settings.colorscheme.theme or 'terafox'

local found, palette = pcall(require, colorscheme .. '.palette')
if not found then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

local found_theme, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
if not found_theme then
  vim.notify('Theme "' .. theme .. '" of "' .. colorscheme .. '" colorscheme not found!')
  return
end

local found_modes, modes = pcall(require, 'modes')
if not found_modes then
  vim.notify('nightfox: "modes" could not be found')
  return
end
-- needs to been calld after colorscheme is established
modes.setup()

local color = palette.load(theme)
-- inspect available colors
-- vim.pretty_print('color:', color)

-- adjust colors
vim.api.nvim_set_hl(0, 'CursorLine', { bg = color.bg1 }) -- disable default color
