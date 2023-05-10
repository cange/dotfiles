local icon = Cange.get_icon

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
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        opts = {},
        config = function(_, opts) require("copilot_cmp").setup(opts) end,
      },
      { -- AI code suggestions
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          max_lines = 1000,
          max_num_results = 10,
          sort = true, -- results by returned priority
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          show_prediction_strength = false,
        },
        config = function(_, opts) require("cmp_tabnine.config").setup(opts) end,
      },
    },
    -- FIXME: https://github.com/hrsh7th/nvim-cmp/pull/1563
    commit = "1cad30fcffa282c0a9199c524c821eadc24bf939",
    config = function()
      local cmp = require("cmp")

      cmp.setup(require("cange.cmp").opts)

      -- https://github.com/hrsh7th/cmp-cmdline
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      panel = { enabled = false, auto_refresh = true },
      suggestion = { enabled = false, auto_refresh = true },
    },
    config = function(_, opts) require("copilot").setup(opts) end,
  },
}
