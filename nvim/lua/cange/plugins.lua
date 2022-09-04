-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, 'packer')
if not ok then
  print('Packer is not installed')
  return
end

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

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
  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }, -- optional, for file icons
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use 'numToStr/Comment.nvim' -- comment toggle

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- enable LSP
    requires = {
      'williamboman/mason.nvim', -- simple to use language server installer
      'WhoIsSethDaniel/mason-tool-installer.nvim' -- Mason that allow you to automatically install/update
      -- 'glepnir/lspsaga.nvim', -- LSP UIs
    }
  }

  -- snippets
  use 'L3MON4D3/LuaSnip' --snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- auto completion
  use {
    'hrsh7th/nvim-cmp', -- code completion
    requires = {
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'hrsh7th/cmp-path', -- path completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      'L3MON4D3/LuaSnip', -- snippets
      'hrsh7th/cmp-buffer', -- source for buffer words
      'hrsh7th/cmp-nvim-lsp', -- source for neovim’s built-in LSP
      'hrsh7th/cmp-nvim-lua',
    }
  }

  -- syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- brackets
  use 'windwp/nvim-autopairs' -- close brackets, quotes etc
  use 'windwp/nvim-ts-autotag' -- autoclose and autorename html tag
  use {
    'p00f/nvim-ts-rainbow', -- Rainbow parentheses 
    requires = {
      'nvim-treesitter/nvim-treesitter'
    }
  }

  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'mg979/vim-visual-multi' -- multi select search/replace

  use 'norcalli/nvim-colorizer.lua' -- color highlighter
  use 'lewis6991/gitsigns.nvim' -- git highlighter, blame, etc
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
