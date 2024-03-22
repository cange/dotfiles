local icons = {
  disconnect = "", --  :nf-cod-debug_disconnect
  pause = "", -- :nf-cod-debug_pause
  play = "", -- :nf-cod-debug_start
  run_last = "", -- :nf-cod-debug_restart
  step_back = "", -- :nf-cod-debug_step_back
  step_into = "", -- :nf-cod-debug_step_into
  step_out = "", -- :nf-cod-debug_step_out
  step_over = "", -- :nf-cod-debug_step_over
  terminate = "", -- :nf-cod-debug_stop
  breakpoint = "", -- :nf-cod-debug_stackframe
  breakpoint_active = "", -- :nf-cod-debug_stackframe_active
}

return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = {
      automatic_setup = true,
      ensure_installed = { "js-debug-adapter", "firefox" },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = "rcarriga/nvim-dap-ui",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- JS/TS debugging
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = 8123,
        executable = { command = "js-debug-adapter" },
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

      -- For more information, see |:help nvim-dap-ui|
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      dapui.setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = icons,
        },
      })
    end,
    keys = function()
      local dap = require("dap")
      local dapui = require("dapui")

      return {
        { "<leader>d<F7>", dapui.toggle, desc = "Debug: Toggle session" },
        { "<leader>d<F8>", dap.continue, desc = icons.play .. " Start/Continue" },
        { "<leader>d<F10>", dap.step_over, desc = icons.step_over .. " Step Over" },
        { "<leader>d<F11>", dap.step_into, desc = icons.step_into .. " Step Into" },
        { "<leader>d<F12>", dap.step_out, desc = icons.step_out .. " Step Out" },
        { "<leader>d<F12>", dap.r, desc = icons.step_out .. " Step Out" },
        { "<Leader>dl", dap.run_last, desc = icons.run_last .. " Run Last" },
        { "<leader>db", dap.toggle_breakpoint, desc = icons.breakpoint_active .. " Toggle Breakpoint" },
        {
          "<leader>dB",
          function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
          desc = icons.breakpoint .. " Set Breakpoint",
        },
      }
    end,
  },
}
