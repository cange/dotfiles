---Simplified setup method
---@param plugin_name string The packages module name to call for setup
---@return function
local function instant_setup(plugin_name)
  return function()
    require(plugin_name).setup()
  end
end

return {
  -- UI: Cursorline
  "RRethy/vim-illuminate", -- Highlight the word under the cursor

  -- UI: winbar
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" }, -- A statusline/winbar component

  -- Utility

  -- Scrolling
  { "karb94/neoscroll.nvim", config = instant_setup("neoscroll") }, -- smooth scrolling

  -- File explorer
  { "ThePrimeagen/harpoon", lazy = false, dependencies = "nvim-lua/plenary.nvim" }, -- bookmark buffers

  -- Comment
  { "numToStr/Comment.nvim", config = instant_setup("Comment") }, -- comment toggle

  -- Syntax
  { "m-demare/hlargs.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- highlight arguments' definitions
  "slim-template/vim-slim", -- slim language support (Vim Script,

  -- Snippets
  "L3MON4D3/LuaSnip", --snippet engine

  -- LSP / Language Server Protocol
  {
    "neovim/nvim-lspconfig", -- configure LSP servers
    dependencies = {
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
      "jose-elias-alvarez/null-ls.nvim", -- syntax formatting, diagnostics (dependencies npm pacakges)
      "jose-elias-alvarez/typescript.nvim", -- enables LSP features for TS/JS
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
    },
    config = function()
      Cange.reload('cange.lsp')
    end,
  },

  "b0o/SchemaStore.nvim", -- json/yaml schema support

  -- Completion
  {
    "hrsh7th/nvim-cmp", -- code completion
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippets
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
      Cange.reload("cange.cmp")
    end,
  },

  -- Color
  { "norcalli/nvim-colorizer.lua", config = instant_setup("colorizer") }, -- color highlighter

  -- Editing support
  { "windwp/nvim-ts-autotag", config = instant_setup("nvim-ts-autotag") }, -- autoclose and autorename html tags
  { "mrjones2014/nvim-ts-rainbow", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- Rainbow parentheses

  "mg979/vim-visual-multi", -- multi search and replace

  -- Icons
  {
    "kyazdani42/nvim-web-devicons", -- File icons
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },
}
