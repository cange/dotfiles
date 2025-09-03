return {
  { -- A collection of small convenience plugins
    "folke/snacks.nvim",
    priority = 1000,
    version = "v2.*",
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dim = { animate = { enabled = false } },
      indent = { animate = { enabled = false } },
      input = { enabled = true },
      lazygit = { theme = { activeBorderColor = { fg = "String", bold = true } } },
      notifier = {
        icons = {
          error = Icon.diagnostics.Error,
          warn = Icon.diagnostics.Warn,
          info = Icon.diagnostics.Info,
          debug = Icon.ui.Bug,
          trace = Icon.ui.Edit,
        },
      },
      notify = { enabled = true },
      statuscolumn = {},
      words = {},
    },
    keys = function()
      local Snacks = require("snacks")
      local toggler = Snacks.toggle
      return {
        { "<Leader>z", function() Snacks.zen.zoom() end, desc = "Toggle Zen" },
        { "<LocalLeader>z", function() Snacks.dim() end, desc = "Toggle Dimming" },
        { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<Leader>dd", function() toggler.diagnostics():toggle() end, desc = "[diag] Toggle highlighting" },
        { "<Leader>en", function() Snacks.notifier.show_history() end, desc = "Show notfication" },
        { "<Leader>em", function() Snacks.notifier.hide() end, desc = "Muted notfication" },
        { "<Leader>,N", function() toggler.line_number():toggle() end, desc = "Toggle line numbers" },
        { "<Leader>,n", function() toggler.option("relativenumber"):toggle() end, desc = "Toggle relative number" },
        { "<Leader>,s", function() toggler.option("spell"):toggle() end, desc = "Toggle spelling" },
        { "<Leader>,w", function() toggler.option("wrap"):toggle() end, desc = "Toggle wrap" },
        { "<Leader>gf", function() Snacks.lazygit.log_file() end, desc = "Current File History" },
        { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
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
        Notify._info(("[%s]: %s"):format(title or "", msg), opts)
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
}
