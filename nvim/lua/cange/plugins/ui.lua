local i = Cange.get_icon

return {
  -- advanced colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = { char = i("ui.VThinLine") } },

  { -- indentation guides to all lines
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      exclude = { filetypes = { "help", "dashboard", "NvimTree", "lazy", "mason", "notify" } },
      indent = { char = i("ui.VThinLineLeft") },
    },
  },

  { -- popover notification
    "rcarriga/nvim-notify",
    opts = {
      icons = {
        ERROR = i("diagnostics.Error"),
        WARN = i("diagnostics.Warn"),
        INFO = i("diagnostics.Info"),
        DEBUG = i("ui.Bug"),
        TRACE = i("ui.Edit"),
      },
      timeout = 3000,
      render = "compact",
      top_down = false,
    },
    init = function() vim.notify = require("notify") end,
  },

  { -- Improve the built-in vim.ui interfaces with telescope, fzf, etc
    "stevearc/dressing.nvim",
    lazy = true,
    event = { "VimEnter" },
  },

  { -- Distraction-free coding
    "folke/zen-mode.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      window = {
        width = 160, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    },
  },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
      require("cange.utils.icons").setup()
    end,
  },
}
