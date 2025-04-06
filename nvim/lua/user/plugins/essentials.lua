return {
  { -- A collection of small convenience plugins
    "folke/snacks.nvim",
    priority = 1000,
    version = "v2.22.0",
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dim = { animate = { enabled = false } },
      indent = { animate = { enabled = false } },
      input = { enabled = true },
      lazygit = { theme = { activeBorderColor = { fg = "String", bold = true } } },
      notifier = {
        enabled = true,
        style = "minimal",
        icons = {
          error = Icon.diagnostics.Error,
          warn = Icon.diagnostics.Warn,
          info = Icon.diagnostics.Info,
          debug = Icon.ui.Bug,
          trace = Icon.ui.Edit,
        },
        top_down = false,
      },
      notify = { enabled = true },
      statuscolumn = {},
    },
    keys = function()
      local Snacks = require("snacks")
      local toggler = Snacks.toggle
      return {
        { "<leader>z", function() Snacks.zen.zoom() end, desc = "Toggle Zen" },
        { "<localleader>z", function() Snacks.dim() end, desc = "Toggle Dimming" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cd", function() toggler.diagnostics():toggle() end, desc = "Toggle diagnostic inline text" },
        { "<leader>en", function() Snacks.notifier.show_history() end, desc = "Show notfication" },
        { "<leader>,N", function() toggler.line_number():toggle() end, desc = "Toggle line numbers" },
        { "<leader>,n", function() toggler.option("relativenumber"):toggle() end, desc = "Toggle relative number" },
        { "<leader>,s", function() toggler.option("spell"):toggle() end, desc = "Toggle spelling" },
        { "<leader>,w", function() toggler.option("wrap"):toggle() end, desc = "Toggle wrap" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Current File History" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      }
    end,
    init = function()
      local Snacks = require("snacks")

      -- notifications
      Notify = Snacks.notify
      Notify._info = Notify.info
      ---@diagnostic disable-next-line: duplicate-set-field
      Notify.info = function(msg, opts)
        opts = opts or {}
        local title = opts.title and type(opts.title) == "string" and opts.title or ""
        opts.title = "user-config"
        Notify._info(string.format("[%s]: %s", title or "", msg), opts)
      end

      -- debug
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          ---@diagnostic disable-next-line: duplicate-set-field
          _G.dd = function(...) Snacks.debug.inspect(...) end
          vim.print = _G.dd -- Override print to use snacks for `:=` command
        end,
      })
    end,
  },

  -- advanced colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = { char = Icon.ui.LineThin } },

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
          fold_open = Icon.ui.ChevronDown,
          fold_closed = Icon.ui.ChevronRight,
        },
        folder_closed = Icon.documents.Folder,
        folder_open = Icon.documents.OpenFolder,
        kinds = Icon.cmp_kinds,
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
