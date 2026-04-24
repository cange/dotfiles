return { -- keymaps
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",

    icons = {
      mappings = false,
      breadcrumb = "",
      group = Icon.ui.ChevronRight .. " ",
      separator = "",
      colors = false,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")

    wk.setup(opts)
    wk.add(vim.tbl_extend("keep", {
      -- groups
      { "<Leader>b", group = "Buffers" },
      { "<Leader>c", group = "Code" },
      { "<Leader>e", group = "Editor" },
      { "<Leader>,", group = "Settings" },
      { "<Leader>g", group = "Git" },
      { "<Leader>a", group = "AI", mode = { "n", "v" } },
      { "<Leader>d", group = "Diff / Diagnostics", mode = { "n", "v" } },
      { "<Leader>q", group = "Session" },
      { "<Leader>s", group = "Search" },
      { "<Leader>t", group = "Troubleshooting" },
      { "g", group = "Code/LSP" },
      -- direct keymaps
      { "<Leader>-", "<C-W>s", desc = "Split horizontal" },
      { "<Leader>|", "<C-W>v", desc = "Split vertical" },
    }, require("user.copilot").which_key))
  end,
}
