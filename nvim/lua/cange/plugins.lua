local ns = "cange.plugins"
-- Use a protected call so we don't error out on first use
local found, packer = pcall(require, "packer")
if not found then
  print("[" .. ns .. "] Packer is not installed")
  return
end

-- Have packer use a print()opup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})
-- helpers

---Simplified setup method
--- @param pack_name string The packages module name to call for setup
--- @return {}|nil
local function instant_setup(pack_name)
  local found_pack, pack = pcall(require, pack_name)
  if not found_pack then
    print("[" .. ns .. '] "' .. pack_name .. '" not found')
    return
  end

  return pack.setup()
end

packer.startup(function(use)
  local web_icons = "kyazdani42/nvim-web-devicons"
  -- Plugin Manager
  use("wbthomason/packer.nvim") -- package manager

  -- UI
  use("EdenEast/nightfox.nvim") -- theme

  -- UI: Statusline
  use({
    "nvim-lualine/lualine.nvim", -- status line
    requires = { web_icons, opt = true },
  })
  -- UI: Cursorline
  use("RRethy/vim-illuminate") -- Highlight the word under the cursor

  -- UI: winbar
  use({
    "SmiteshP/nvim-navic", -- A statusline/winbar component
    requires = "neovim/nvim-lspconfig",
  })

  -- Terminal
  use("akinsho/toggleterm.nvim") -- inline Terminal

  -- Startup
  use({
    "goolord/alpha-nvim", -- startup screen
    requires = { web_icons },
  })

  -- Utility
  use("rcarriga/nvim-notify") -- popover notification
  use("mvllow/modes.nvim") -- Prismatic line decorations

  -- Project
  use("ahmedkhalf/project.nvim")

  -- Keybinding
  use("folke/which-key.nvim")

  -- Scrolling
  use({
    "karb94/neoscroll.nvim", -- smooth scrolling
    config = instant_setup("neoscroll"),
  })

  -- Fuzzy Finder
  use({
    "nvim-telescope/telescope.nvim", -- fuzzy finder over lists
    requires = {
      "nvim-lua/plenary.nvim", -- common lua functions - https://github.com/nvim-lua/plenary.nvim
      "nvim-telescope/telescope-file-browser.nvim", -- browser extension
      "BurntSushi/ripgrep", -- telescope live grep suggestions
    },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- telescope , for better performance

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { web_icons }, -- optional, for file icons
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })

  -- Comment
  use({
    "numToStr/Comment.nvim", -- comment toggle
    config = instant_setup("Comment"),
  })

  -- Indent
  use("lukas-reineke/indent-blankline.nvim")

  -- Syntax
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground") -- inspect syntax node anatomy
  use({
    "m-demare/hlargs.nvim", -- highlight arguments' definitions
    requires = { "nvim-treesitter/nvim-treesitter" },
  })
  use("slim-template/vim-slim") -- slim language support (Vim Script)

  -- Snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use({ -- (requires additional npm packages)
    "williamboman/mason.nvim", -- simple to use language server installer
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig", -- enable LSP
    },
  })
  use("b0o/SchemaStore.nvim") -- json/yaml schema support
  use("jose-elias-alvarez/null-ls.nvim") -- syntax formatting, diagnostics (requires npm pacakges)
  use({
    "MunifTanjim/prettier.nvim", -- JS formatter
    requires = {
      "jose-elias-alvarez/null-ls.nvim",
      "neovim/nvim-lspconfig",
    },
  })
  use("onsails/lspkind.nvim") -- plugin adds vscode-like icons
  use("j-hui/fidget.nvim") -- shows LSP initialization progress

  -- Completion
  use({
    "hrsh7th/nvim-cmp", -- code completion
    requires = {
      "L3MON4D3/LuaSnip", -- snippets
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
  })
  use({
    "tzachar/cmp-tabnine", -- AI code suggestions
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  })

  -- Session
  use("rmagatti/auto-session") -- small automated session manager
  use("rmagatti/session-lens") -- extends auto-session through Telescope

  -- Icon
  use(web_icons) -- File icons

  -- Color
  use({
    "norcalli/nvim-colorizer.lua", -- color highlighter
    config = instant_setup("colorizer"),
  })

  -- Git
  use("lewis6991/gitsigns.nvim") -- git highlighter, blame, etc
  use("dinhhuy258/git.nvim") -- For git blame & browse

  -- Editing support
  use("windwp/nvim-autopairs") -- close brackets, quotes etc
  use({
    "windwp/nvim-ts-autotag", -- autoclose and autorename html tags
    config = instant_setup("nvim-ts-autotag"),
  })
  use({
    "p00f/nvim-ts-rainbow", -- Rainbow parentheses
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  })
  use("johmsalas/text-case.nvim") -- text case converter (camel case, etc.)
  use("folke/zen-mode.nvim") -- Distraction-free coding
end)
