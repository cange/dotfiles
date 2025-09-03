return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = function()
      return {
        { "<LocalLeader>-", require("oil").toggle_float, desc = "Open parent directory" },
      }
    end,
    opts = {
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 4,
        max_width = 0.6,
        max_height = 0.6,
      },
    },
  },
}
