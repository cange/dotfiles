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
    },
    config = function() require("cange.cmp") end,
  },

  { "L3MON4D3/LuaSnip" }, --snippet engine

  { -- AI code suggestions
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
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

  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    dependencies = "zbirenbaum/copilot-cmp",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("copilot").setup({
        panel = { enabled = false, auto_refresh = true },
        suggestion = { enabled = false, auto_refresh = true },
      })
      require("copilot_cmp").setup({ formatters = { insert_text = require("copilot_cmp.format").remove_existing } })
    end,
  },

  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = "zbirenbaum/copilot.lua",
    lazy = true,
    config = function()
      require("copilot_status").setup({
        icons = {
          idle = icon("ui.Octoface"),
          error = icon("diagnostics.Error"),
          warning = icon("diagnostics.Warn"),
          loading = icon("ui.Sync"),
          offline = icon("ui.Stop"),
        },
        debug = true,
      })
    end,
  },
}
