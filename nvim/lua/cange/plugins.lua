-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, 'packer')
if not ok then
  print('Packer is not installed')
  return
end

-- Automatically install packer
-- local fn = vim.fn
-- local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   PACKER_BOOTSTRAP = fn.system {
--     'git',
--     'clone',
--     '--depth',
--     '1',
--     'https://github.com/wbthomason/packer.nvim',
--     install_path,
--   }
--   print 'Installing packer close and reopen Neovim...'
--   vim.cmd [[packadd packer.nvim]]
-- end
--
-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--   autocmd!
--   autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

local function instant_setup(pack_name)
  local found, pack = pcall(require, pack_name)
  if not found then
    vim.notify('packer: "'..pack_name..'" could not be found')
    return
  end

  return pack.setup()
end
local function npm_install(packages, description)
  return 'echo "  installing '..description..' JavaScript binaries" && npm install --global --force '.. packages
end

packer.startup(function(use)
  -- Plugin Manager
  use 'wbthomason/packer.nvim' -- package manager

  -- UI
  use 'EdenEast/nightfox.nvim' -- theme

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim', -- status line
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = instant_setup('lualine'),
  }

  -- Tabline
  use 'akinsho/nvim-bufferline.lua' -- tab UI

  -- Utility
  use {
    'rcarriga/nvim-notify', -- popover notification
    config = function() vim.notify = require('notify') end,
  }
  -- Project
  use 'ahmedkhalf/project.nvim'

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder over lists
    requires = {
      'nvim-lua/plenary.nvim', -- common lua functions - https://github.com/nvim-lua/plenary.nvim
      'nvim-telescope/telescope-file-browser.nvim', -- browser extension
      'BurntSushi/ripgrep', -- telescope live grep suggestions
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- telescope , for better performance

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }, -- optional, for file icons
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { 'numToStr/Comment.nvim', -- comment toggle
    config = instant_setup('Comment'),
  }

  -- Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Snippets
  use 'L3MON4D3/LuaSnip' --snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use {
    'williamboman/mason.nvim', -- simple to use language server installer
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig', -- enable LSP
    },
    -- install JavaScript related dependencies
    run = npm_install('typescript-language-server typescript', 'LSP')
  }
  use 'b0o/SchemaStore.nvim' -- json/yaml schema support
  use {
    'jose-elias-alvarez/null-ls.nvim', -- syntax formatting
    -- install JavaScript related dependencies
    run = npm_install('@fsouza/prettierd eslint_d', 'null-ls')
  }
  use {
    'MunifTanjim/prettier.nvim', -- JS formatter
    requires = 'jose-elias-alvarez/null-ls.nvim',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp', -- code completion
    requires = {
      'L3MON4D3/LuaSnip', -- snippets
      'hrsh7th/cmp-buffer', -- source for buffer words
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'hrsh7th/cmp-nvim-lsp', -- source for neovim’s built-in LSP
      'hrsh7th/cmp-nvim-lua', -- Neovim's Lua API
      'hrsh7th/cmp-path', -- path completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
    }
  }
  use {
    'tzachar/cmp-tabnine', -- AI code suggestions
    run = './install.sh', requires = 'hrsh7th/nvim-cmp'
  }

  -- Icon
  use 'kyazdani42/nvim-web-devicons' -- File icons

  -- Color
  use {
    'norcalli/nvim-colorizer.lua', -- color highlighter
    config = instant_setup('colorizer'),
  }

  -- Git
  use 'lewis6991/gitsigns.nvim' -- git highlighter, blame, etc
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Editing support
  use 'windwp/nvim-autopairs' -- close brackets, quotes etc
  use {
    'windwp/nvim-ts-autotag', -- autoclose and autorename html tags
    config = instant_setup('nvim-ts-autotag'),
  }
  use {
    'p00f/nvim-ts-rainbow', -- Rainbow parentheses
    requires = {
      'nvim-treesitter/nvim-treesitter'
    }
  }
  use 'mg979/vim-visual-multi' -- multi select search/replace
  use 'johmsalas/text-case.nvim' -- text case converter (camel case, etc.)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- if PACKER_BOOTSTRAP then
  --   packer.sync()
  -- end
end)
