---Simplified setup method
---@param plugin_name string The packages module name to call for setup
---@return function
local function instant_setup(plugin_name)
  return function()
    require(plugin_name).setup()
  end
end

return {
  -- UI
  "EdenEast/nightfox.nvim", -- theme

  -- UI: Cursorline
  "RRethy/vim-illuminate", -- Highlight the word under the cursor

  -- UI: winbar
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" }, -- A statusline/winbar component

  -- Utility

  -- Scrolling
  { "karb94/neoscroll.nvim", config = instant_setup("neoscroll") }, -- smooth scrolling

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
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
      "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim", -- syntax formatting, diagnostics (dependencies npm pacakges)
    dependencies = {
      "williamboman/mason.nvim", -- managing & installing LSP servers, linters & formatters
      "jayp0521/mason-null-ls.nvim", -- bridges mason.nvim with the null-ls plugin
    },
  },
  { "jose-elias-alvarez/typescript.nvim", dependencies = "neovim/nvim-lspconfig" }, -- enables LSP features for TS/JS
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
  },

  -- Color
  { "norcalli/nvim-colorizer.lua", config = instant_setup("colorizer") }, -- color highlighter

  -- Git

  -- Editing support
  { "windwp/nvim-ts-autotag", config = instant_setup("nvim-ts-autotag") }, -- autoclose and autorename html tags
  { "p00f/nvim-ts-rainbow", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- Rainbow parentheses

  "mg979/vim-visual-multi", -- multi search and replace
}
