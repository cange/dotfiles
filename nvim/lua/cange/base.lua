-- basic lua commands https://github.com/nanotee/nvim-lua-guide

-- Set leader
vim.g.mapleader = ' '

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste'
})
