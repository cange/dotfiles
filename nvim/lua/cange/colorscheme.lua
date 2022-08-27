-- theme https://github.com/EdenEast/nightfox.nvim#usage
local colorscheme = 'nightfox'
local theme = 'terafox'

local ok, _ = pcall(require, colorscheme)
if not ok then
  print('colorscheme ' .. colorscheme .. ' not found!')
  return
end

local theme_ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
if not theme_ok then
  print('Theme "' .. theme .. '" of "' .. colorscheme .. '" colorscheme not found!')
  return
end
