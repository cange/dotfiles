local options = {
  backspace = 'start,eol,indent', -- allow backspace in insert mode
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file
  timeoutlen = 600, -- max delay until execute command of a key sequence
  ttimeoutlen = 50, -- max time unti next key of a key sequence is expected
  list = true, -- show hidden characters

  -- UI
  colorcolumn = '80,120', -- highlight optimal end line¬
  cursorline = true, -- highlight the current line
  guifont = 'monospace:h17', -- the font used in graphical neovim applications
  laststatus = 3, -- show one global statusline for all windows
  mouse = 'a', -- allow the mouse to be used in editor
  termguicolors = true, -- set term gui colors (most terminals support this)
  number = true, -- set numbered lines
  numberwidth = 3, -- set number column width to 2 {default 4}
  relativenumber = false, -- set relative numbered lines
  title = true, -- Update terminal window title

  -- backup handling
  backup = false, -- creates a backup file
  backupskip = '/tmp/*,/private/tmp/*',
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

  -- command prompt
  cmdheight = 2, -- space ofthe command line for displaying messages
  showmode = false, -- don't show mode message like, -- INSERT, -- since statusline 'lualine' is is doing it
  showcmd = true, -- show incomplete commands

  -- search
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- don't ignore cases if search term contains upper-case characters

  -- tabs
  expandtab = true, -- convert tabs to spaces
  showtabline = 2, -- always show tabs
  tabstop = 2, -- number of spaces for a tab

  -- indentation
  autoindent = false, -- auto indent on copy paste
  breakindent = true, -- indentation when wrapping text
  shiftwidth = 2, -- number of spaces inserted for each indentation
  smartindent = true, -- make indenting smarter again

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile

  --
  scrolloff = 8, -- scroll offset horizontal
  sidescrolloff = 8, -- scroll offset vertical
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  undofile = true, -- enable persistent undo
  wrap = false, -- display lines as one long line

  -- folding settings
  foldlevel = 10, -- this is just what i use
  foldmethod = 'indent', -- fold based on indent
  foldnestmax = 10, -- deepest fold is 10 levels
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

--
vim.opt.iskeyword:append({ '-' })
vim.opt.formatoptions:remove({ 'cro' }) -- adjust automatic formatting
vim.opt.formatoptions:append({ 'r' }) -- Add asterisks in block comments
vim.opt.shortmess:append({ c = true }) -- don't give |ins-completion-menu| messages
vim.opt.path:append({ '**' }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ -- stuff to ignore when tab completing
  '*.o',
  '*.obj',
  '*.png', '*.jpg', '*.gif', '*.pdf', '*.psd',
  '*/node_modules/*',
  '*/tmp/*', '*.scssc', '*.so', '*.swp', '*.zip',
  '*DS_Store*',
  '*~',
})

-- vim.opt.whichwrap:append({ '<', '>', '[', ']', 'h', 'l' })
vim.opt.listchars:append({
  eol = "",
  nbsp = "_",
  tab = " ",
})