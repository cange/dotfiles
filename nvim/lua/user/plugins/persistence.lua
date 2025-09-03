return { -- small automated session manager
  "folke/persistence.nvim",
  dependencies = { "nvim-tree/nvim-tree.lua" },
  event = "BufReadPre",
  opts = {
    options = vim.opt.sessionoptions:get(),
    pre_save = function() require("nvim-tree.api").tree.close() end,
  },
  keys = {
    { "<Leader>qr", function() require("persistence").load({ last = true }) end, desc = "Recent Session" },
    { "<Leader>qs", function() require("persistence").save() end, desc = "Save session" },
    { "<Leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    { "<Leader>qS", function() require("persistence").select() end, desc = "Select a session" },
  },
  init = function() require("persistence").load() end,
}
