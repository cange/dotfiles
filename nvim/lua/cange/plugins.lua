local loaded, packer = pcall(require, 'packer')
if (not loaded) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- package manager
  use 'EdenEast/nightfox.nvim' -- theme
  use {
    'nvim-lualine/lualine.nvim', -- status line
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'akinsho/nvim-bufferline.lua' -- tab UI

  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder over lists

    requires = {
      'nvim-lua/plenary.nvim', -- lua comment functions - https://github.com/nvim-lua/plenary.nvim
      'nvim-telescope/telescope-file-browser.nvim', -- browser extension
      'BurntSushi/ripgrep', -- telescope live grep suggestions

      'nvim-telescope/telescope-fzf-native.nvim', -- sorter, for better performance
      run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
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
end)
