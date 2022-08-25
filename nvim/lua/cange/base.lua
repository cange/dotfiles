-- basic lua commands https://github.com/nanotee/nvim-lua-guide

local cmd = vim.cmd
local opt = vim.opt

-- Set leader
vim.g.mapleader = ' '

cmd('autocmd!')

-- Undercurl
cmd([[let &t_Cs = "\e[4:3m"]])
cmd([[let &t_Ce = "\e[4:0m"]])
-- Note: this does not work on iTerm2


-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste'
})
