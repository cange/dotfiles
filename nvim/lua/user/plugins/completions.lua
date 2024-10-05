return {
  { -- code completion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippets
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "chrisgrieser/cmp-nerdfont",
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        opts = {},
        config = function(_, opts) require("copilot_cmp").setup(opts) end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local max_count = 16

      cmp.setup(require("user.cmp").opts)

      -- https://github.com/hrsh7th/cmp-cmdline
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", max_item_count = max_count },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path", max_item_count = max_count },
        }, {
          { name = "cmdline", max_item_count = max_count },
        }),
      })
    end,
  },
}
