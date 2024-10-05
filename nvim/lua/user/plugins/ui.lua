local icons = require("user.icons")

return {
  -- advanced colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = { char = icons.ui.LineThin } },

  { -- indentation scope lines
    "echasnovski/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup({
        symbol = icons.ui.LineLeftThin,
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
      })
    end,
  },

  { -- popover notification
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      -- NOTE: needs to be delayed to apply background_colour
      require("notify").setup({
        level = User.get_config("log.level"),
        icons = {
          ERROR = icons.diagnostics.Error,
          WARN = icons.diagnostics.Warn,
          INFO = icons.diagnostics.Info,
          DEBUG = icons.ui.Bug,
          TRACE = icons.ui.Edit,
        },
        background_colour = "#000000",
        render = "compact",
        timeout = 3000,
        top_down = false,
      })
    end,
    init = function() vim.notify = require("notify") end,
  },

  { -- Improve the built-in vim.ui interfaces with telescope, fzf, etc
    "stevearc/dressing.nvim",
    lazy = true,
    event = { "VimEnter" },
  },

  { -- Distraction-free coding
    "folke/zen-mode.nvim",
    dependencies = "folke/twilight.nvim", -- dimmer
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      window = {
        width = 1,
        height = 1,
      },
    },
    keys = {
      { "<localleader>z", "<cmd>ZenMode<CR><cmd>TwilighEnable<CR>", desc = "Toggle Zen Focus Mode" },
      { "<leader>z", "<cmd>ZenMode<CR><cmd>TwilightDisable<CR>", desc = "Toggle Zen Mode" },
    },
  },

  { -- font icon set
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
      require("user.utils.icons").setup()
    end,
  },

  { -- A pretty list for showing diagnostics
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      icons = {
        indent = {
          fold_open = icons.ui.ChevronDown,
          fold_closed = icons.ui.ChevronRight,
        },
        folder_closed = icons.documents.Folder,
        folder_open = icons.documents.OpenFolder,
        kinds = icons.cmp_kinds,
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)

      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        group = vim.api.nvim_create_augroup("before_troubleshooting_list_close", { clear = true }),
        desc = "Close troubleshooting list",
        callback = function() require("trouble").close() end,
      })
    end,
    keys = {
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ...",
      },
      { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
      { "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
      { "<leader>tx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
    },
  },
}
