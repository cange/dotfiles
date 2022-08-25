local ok, packer = pcall(require, 'packer')
if not ok then
  print('Packer is not installed')
  return
end

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- package manager
  use 'EdenEast/nightfox.nvim' -- theme
  use {
    'nvim-lualine/lualine.nvim', -- status line
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'akinsho/nvim-bufferline.lua' -- tab UI

  -- navigation
  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder over lists
    requires = {
      'nvim-lua/plenary.nvim', -- lua comment functions - https://github.com/nvim-lua/plenary.nvim
      'nvim-telescope/telescope-file-browser.nvim', -- browser extension
      'BurntSushi/ripgrep', -- telescope live grep suggestions
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- telescope , for better performance
  -- sidebar nav
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }, -- optional, for file icons
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'numToStr/Comment.nvim' -- comment toggle
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'neovim/nvim-lspconfig' -- config Language Server Protocol
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip' -- nvim-cmp snippet engine
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim’s built-in LSP
  use 'hrsh7th/nvim-cmp' -- code completion

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'windwp/nvim-autopairs' -- close brackets, quotes etc
  use 'windwp/nvim-ts-autotag' -- autoclose and autorename html tag

  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'mg979/vim-visual-multi' -- multi select search/replace

  use 'norcalli/nvim-colorizer.lua' -- color highlighter
  use 'lewis6991/gitsigns.nvim' -- git highlighter, blame, etc
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  if PACKER_BOOTSTRAP then require("packer").sync() end
end)
