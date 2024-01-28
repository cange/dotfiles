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
      "hrsh7th/cmp-nvim-lsp-signature-help", -- source displaying function signatures with the current parameter
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
      { -- AI code suggestions
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        opts = {
          max_lines = 1000,
          max_num_results = 10,
          sort = true, -- results by returned priority
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          show_prediction_strength = false,
        },
      },
    },
    config = function()
      local cmp = require("cmp")
      local max_count = 16

      cmp.setup(require("cange.cmp").opts)

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

  { -- AI code suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      panel = { enabled = false, auto_refresh = true },
      suggestion = { enabled = false, auto_refresh = true },
    },
    -- stylua: ignore start
    keys = {
      { "<leader>cA", "<cmd>Copilot panel accept<CR>",  desc = "Accept Copilot panel" },
      { "<leader>cR", "<cmd>Copilot panel refresh<CR>", desc = "Refresh Copilot panel" },
      { "<leader>cS", "<cmd>Copilot status<CR>",        desc = "Copilot status" },
      { "<leader>co", "<cmd>Copilot toggle<CR>",        desc = "Toggle Copilot" },
      { "<leader>cp", "<cmd>Copilot panel<CR>",         desc = "Toggle Copilot panel" },
      { "<leader>cs", "<cmd>Copilot suggestion<CR>",    desc = "Toggle Copilot suggestion" },
      { "[c", '<cmd>Copilot suggestion prev<CR>',       desc = "Prev Copilot suggestion" },
      { "[p", '<cmd>Copilot panel jump_prev<CR>',       desc = "Prev Copilot panel" },
      { "]c", '<cmd>Copilot suggestion next<CR>',       desc = "Next Copilot suggestion" },
      { "]p", '<cmd>Copilot panel jump_next<CR>',       desc = "Next Copilot panel" },
    },
    -- stylua: ignore end
  },
}
