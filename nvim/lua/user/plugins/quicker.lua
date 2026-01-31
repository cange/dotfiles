return {
  "stevearc/quicker.nvim",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    type_icons = {
      E = Icon.diagnostics.Error,
      W = Icon.diagnostics.Warn,
      I = Icon.diagnostics.Info,
      N = Icon.diagnostics.Info,
      H = Icon.diagnostics.Hint,
    },
  },
  keys = {
    {
      ">",
      function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
      desc = "Expand quickfix context",
    },
    { "<", function() require("quicker").collapse() end, desc = "Collapse quickfix context" },
    { "<leader>q", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
    { "<leader>l", function() require("quicker").toggle({ loclist = true }) end, desc = "Toggle loclist" },
  },
}
