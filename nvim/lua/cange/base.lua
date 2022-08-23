local cmd = vim.cmd
local opt = vim.opt
local wo  = vim.wo

cmd('autocmd!')

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.number = true

opt.title = true
opt.autoindent = true
opt.hlsearch = true
opt.mouse = a -- allows the use of the mouse in the editor

opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.expandtab = true
opt.scrolloff = 10
opt.shell = 'zsh'
opt.backup = false
opt.backupskip = '/tmp/*,/private/tmp/*'
opt.inccommand = 'split'
opt.ignorecase = true
opt.smarttab = true
opt.breakindent = true

-- Tab size
opt.expandtab = true -- transforms tabs into spaces
opt.shiftwidth = 2 -- number of spaces for indentation
opt.tabstop = 2 -- number of spaces for tabs

opt.ai = true -- Auto indent
opt.si = true -- Smart indent

opt.colorcolumn = '80,120' -- highlight optimal end line¬
opt.wrap = false -- No wrap lines
opt.backspace = 'start,eol,indent'
opt.path:append { '**' } -- Finding files - Search down into subfolders
opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
cmd([[let &t_Cs = "\e[4:3m"]])
cmd([[let &t_Ce = "\e[4:0m"]])
-- Note: this does not work on iTerm2

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste'
})

-- Add asterisks in block comments
opt.formatoptions:append { 'r' }

-- Set leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

--- folding settings
opt.foldmethod = 'indent' -- fold based on indent
opt.foldnestmax = 10 -- deepest fold is 10 levels
-- opt.nofoldenable = true -- dont fold by default
opt.foldlevel = 10 -- this is just what i use
