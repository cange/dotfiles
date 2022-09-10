-- theme https://github.com/EdenEast/nightfox.nvim#usage
local colorscheme = 'nightfox'
local theme = 'terafox'

local found, _ = pcall(require, colorscheme)
if not found then
  vim.notify('colorscheme '..colorscheme..' not found!')
  return
end

local found_theme, _ = pcall(vim.cmd, 'colorscheme '..theme)
if not found_theme then
  vim.notify('Theme "'..theme..'" of "'..colorscheme..'" colorscheme not found!')
  return
end

local found_modes, modes = pcall(require, 'modes')
if not found_modes then
  vim.notify('nightfox: "modes" could not be found')
  return
end
-- needs to been calld after colorscheme is established
modes.setup()
