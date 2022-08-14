local loaded, theme = pcall(require, 'nightfox')

if (not loaded) then return end

vim.cmd('colorscheme terafox') -- theme https://github.com/EdenEast/nightfox.nvim#usage
