vim.cmd('autocmd!')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.mouse = a -- allows the use of the mouse in the editor

vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.backup = false
vim.opt.backupskip = '/tmp/*,/private/tmp/*'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true

-- Tab size
vim.opt.expandtab = true -- transforms tabs into spaces
vim.opt.shiftwidth = 2 -- number of spaces for indentation
vim.opt.tabstop = 2 -- number of spaces for tabs

vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent

vim.opt.colorcolumn = '80,120' -- highlight optimal end line¬
vim.opt.wrap = false -- No wrap lines
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- Note: this does not work on iTerm2

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste'
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- Set leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

--- folding settings
vim.opt.foldmethod = 'indent' -- fold based on indent
vim.opt.foldnestmax = 10 -- deepest fold is 10 levels
-- vim.opt.nofoldenable = true -- dont fold by default
vim.opt.foldlevel = 10 -- this is just what i use
