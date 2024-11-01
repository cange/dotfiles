return {
  { -- code completion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippets
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "hrsh7th/cmp-buffer", -- source for buffer words
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- source for neovim’s built-in LSP
      "hrsh7th/cmp-nvim-lua", -- Neovim's Lua API
      "hrsh7th/cmp-path", -- path completions
      "chrisgrieser/cmp-nerdfont",
    },
    config = function()
      local cmp = require("cmp")
      local max_count = 16
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.expand("~/.config/snippets") })

      cmp.setup(require("user.cmp").opts)

      -- https://github.com/hrsh7th/cmp-cmdline
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", max_item_count = max_count },
        },
      })

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
