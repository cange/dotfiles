-- see: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua
return {
  { -- loads LSP, formatter, linter, debugger
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "js-debug-adapter" },
      auto_update = true,
    },
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
    },
    opts = {},
    keys = function()
      local dap = require("dap")
      local widgets = require("dap.ui.widgets")
      return {
        { "<F8>", dap.continue, desc = "Debug: Continue" },
        { "<F10>", dap.step_over, desc = "Debug: Step over" },
        { "<F11>", dap.step_into, desc = "Debug: Step in" },
        { "<S-F11>", dap.step_out, desc = "Debug: Step out" },
        { "<Leader>db", dap.toggle_breakpoint, desc = "Debug: Toggle breakpoint" },
        { "<Leader>dr", dap.repl.open, desc = "Debug: ?" },
        { "<Leader>dl", dap.run_last, desc = "Debug: ?" },
        { "<Leader>dh", widgets.hover, desc = "Debug: ?", mode = { "n", "v" } },
        { "<Leader>dp", widgets.preview, desc = "Debug: ?", mode = { "n", "v" } },
        {
          "<Leader>dl",
          function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
          desc = "Debug: log message",
        },
        { "<leader>dt", dap.terminate, desc = "Debug: Terminate" },
        { "<Leader>df", function() widgets.centered_float(widgets.frames) end, desc = "Debug: frames?" },
        { "<Leader>ds", function() widgets.centered_float(widgets.scopes) end, desc = "Debug: scopes?" },
        { "<Leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<Leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
      }
    end,
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized.dapui_config = function() dapui.open({}) end
      dap.listeners.before.attach.dapui_config = function() dapui.open({}) end
      dap.listeners.before.launch.dapui_config = function() dapui.open({}) end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close({}) end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close({}) end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = 8123,
        executable = {
          command = "js-debug-adapter",
        },
      }

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
          },
        }
      end
    end,
  },
}
