return {
  { -- code completion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippets
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function() Cange.reload("cange.cmp") end,
  },

  { "L3MON4D3/LuaSnip" }, --snippet engine

  { -- AI code suggestions
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      require("cmp_tabnine.config").setup({
        max_lines = 1000,
        max_num_results = 10,
        sort = true, -- results by returned priority
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        show_prediction_strength = false,
      })
    end,
  },
}
