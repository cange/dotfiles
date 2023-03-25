local options = {
  backspace = "start,eol,indent", -- allow backspace in insert mode
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  timeoutlen = 300, -- max delay until execute command of a key sequence
  ttimeoutlen = 50, -- max time until next key of a key sequence is expected
  list = true, -- show hidden characters
  updatetime = 50, -- faster completion (4000ms default), delays and poor user experience

  -- UI
  cursorline = true, -- highlight the current line
  guifont = "FiraCode Nerd Font:h16", -- the font used in graphical neovim applications
  laststatus = 3, -- show one global statusline for all windows
  mouse = "a", -- allow the mouse to be used in editor
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 3, -- set number column width to 2 {default 4}
  showtabline = 1, -- always show tabs
  termguicolors = true, -- set term gui colors (most terminals support this)
  title = true, -- Update terminal window title
  -- transparency
  pumblend = 16, -- transparency of popup-menus 0 (none) to 100 (full)
  winblend = 0, -- transparency of floating windows 0 (none) to 100 (full)

  -- UI - command prompt
  cmdheight = 0, -- space of the command line for displaying messages
  showmode = false, -- don't show mode message like, -- INSERT, -- since statusline 'lualine' is is doing it
  showcmd = true, -- show incomplete commands
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time

  --
  spell = false, -- enable spell checking if this is true
  spelllang = { "en_us" }, -- spellchecking will be done for these languages

  -- backup handling
  backup = false, -- creates a backup file
  backupskip = "/tmp/*,/private/tmp/*",
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

  -- search
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  path = "**", -- Finding files - Search down into subfolders
  showmatch = true,
  smartcase = true, -- don't ignore cases if search term contains upper-case characters
  wildignore = ".git/*, .DS_Store, *node_modules/*",

  -- tabs
  expandtab = true, -- convert tabs to spaces
  tabstop = 2, -- number of spaces for a tab

  -- indentation
  autoindent = false, -- auto indent on copy paste
  breakindent = true, -- indentation when wrapping text
  colorcolumn = "120", -- highlight optimal end line¬
  formatoptions = "cjnqort", -- line wrap logic
  shiftwidth = 2, -- number of spaces inserted for each indentation
  smartindent = true, -- make indenting smarter again
  swapfile = false, -- creates a swapfile

  -- behaviour
  scrolloff = 8, -- scroll offset horizontal
  sidescrolloff = 8, -- scroll offset vertical
  undofile = true, -- enable persistent undo
  wrap = false, -- display lines as one long line

  -- split windows
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  -- folding settings
  foldlevel = 1, -- zero will close all folds
  foldlevelstart = 4, -- -1 always start editing with all folds closed
  foldmethod = "indent", -- groups of lines with the same indent form a fold
  foldnestmax = 10, -- deepest fold is 10 levels
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.iskeyword:append({ "-" }) --  considers dash "-" as part of a keyword
vim.opt.shortmess:append({ c = true }) -- don't give |ins-completion-menu| messages
vim.opt.listchars:append({ eol = "↵", nbsp = "␣", tab = " ⇥" })

-- Basic Keymaps
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
