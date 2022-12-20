local ns = "[cange.plugins]"
-- helpers

---Simplified setup method
--- @param pack_name string The packages module name to call for setup
--- @return table|nil
local function instant_setup(pack_name)
  local found_pack, pack = pcall(require, pack_name)
  if not found_pack then
    print(ns, '"' .. pack_name .. '" not found')
    return
  end

  return pack.setup()
end

-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd.packadd("packer.nvim")
end

require("packer").startup(function(use)
  local devicons = "kyazdani42/nvim-web-devicons"
  -- Plugin Manager
  use("wbthomason/packer.nvim") -- package manager

  -- UI
  use("EdenEast/nightfox.nvim") -- theme

  -- UI: Statusline
  use({ "nvim-lualine/lualine.nvim", requires = { devicons, opt = true } })
  -- UI: Cursorline
  use("RRethy/vim-illuminate") -- Highlight the word under the cursor

  -- UI: winbar
  use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }) -- A statusline/winbar component

  -- Startup
  use({ "goolord/alpha-nvim", requires = devicons }) -- startup screen

  -- Utility
  use("rcarriga/nvim-notify") -- popover notification

  -- Motion
  use("ggandor/leap.nvim") -- moving fast to a certain location

  -- Keybinding
  use("folke/which-key.nvim")

  -- Scrolling
  use({ "karb94/neoscroll.nvim", config = instant_setup("neoscroll") }) -- smooth scrolling

  -- Fuzzy Finder
  use({
    "nvim-telescope/telescope.nvim", -- fuzzy finder over lists
    requires = {
      "nvim-lua/plenary.nvim", -- common lua functions - https://github.com/nvim-lua/plenary.nvim
      "nvim-telescope/telescope-file-browser.nvim", -- browser extension
      "BurntSushi/ripgrep", -- telescope live grep suggestions
    },
  })
  use("nvim-telescope/telescope-project.nvim") -- switch between projects
  use("nvim-telescope/telescope-ui-select.nvim") -- improved select UI
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- improves search performance

  -- File explorer
  use({ "kyazdani42/nvim-tree.lua", requires = devicons, tag = "nightly" })

  -- Comment
  use({ "numToStr/Comment.nvim", config = instant_setup("Comment") }) -- comment toggle

  -- Indent
  use("lukas-reineke/indent-blankline.nvim")

  -- Syntax
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground") -- inspect syntax node anatomy
  use({ "m-demare/hlargs.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }) -- highlight arguments' definitions
  use("slim-template/vim-slim") -- slim language support (Vim Script)

  -- Snippets
  use("L3MON4D3/LuaSnip") --snippet engine

  -- LSP / Language Server Protocol
  use({
    "neovim/nvim-lspconfig", -- configure LSP servers
    requires = {
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
    },
  })

  use({
    "jose-elias-alvarez/null-ls.nvim", -- syntax formatting, diagnostics (requires npm pacakges)
    requires = {
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
    },
  })
  use({ "jose-elias-alvarez/typescript.nvim", requires = "neovim/nvim-lspconfig" }) -- enables LSP features for TS/JS
  use("b0o/SchemaStore.nvim") -- json/yaml schema support
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
  use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }) -- AI code suggestions

  -- Session
  use("rmagatti/auto-session") -- small automated session manager
  use("rmagatti/session-lens") -- extends auto-session through Telescope

  -- Icon
  use(devicons) -- File icons

  -- Color
  use({ "norcalli/nvim-colorizer.lua", config = instant_setup("colorizer") }) -- color highlighter

  -- Git
  use("lewis6991/gitsigns.nvim") -- git highlighter, blame, etc
  use("dinhhuy258/git.nvim") -- For git blame & browse

  -- Editing support
  use("windwp/nvim-autopairs") -- close brackets, quotes etc
  use({ "windwp/nvim-ts-autotag", config = instant_setup("nvim-ts-autotag") }) -- autoclose and autorename html tags
  use({ "p00f/nvim-ts-rainbow", requires = { "nvim-treesitter/nvim-treesitter" } }) -- Rainbow parentheses

  use("johmsalas/text-case.nvim") -- text case converter (camel case, etc.)
  use("folke/zen-mode.nvim") -- Distraction-free coding
  use("mg979/vim-visual-multi") -- multi search and replace

  -- Markdown
  use({ "toppair/peek.nvim", run = "deno task --quiet build:fast" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if is_bootstrap then
    require("packer").sync()
  end
end)
