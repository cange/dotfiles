local i = Cange.get_icon

return {
  -- advanced colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = { char = i("ui.VThinLine") } },

  { -- indentation scope lines
    "echasnovski/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup({
        symbol = i("ui.VThinLineLeft"),
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
        level = Cange.get_config("log.level"),
        icons = {
          ERROR = i("diagnostics.Error"),
          WARN = i("diagnostics.Warn"),
          INFO = i("diagnostics.Info"),
          DEBUG = i("ui.Bug"),
          TRACE = i("ui.Edit"),
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
      require("cange.utils.icons").setup()
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
          fold_open = i("ui.ChevronDown"),
          fold_closed = i("ui.ChevronRight"),
        },
        folder_closed = i("documents.Folder"),
        folder_open = i("documents.OpenFolder"),
        kinds = i("cmp_kinds"),
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
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ...",
      },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
    },
  },
}
