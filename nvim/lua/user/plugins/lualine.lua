local strUtil = require("user.utils.string")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    opts = function()
      local custom_theme = require("lualine.themes.terafox")
      -- set the bg of lualine_c section to non-transparent
      local mode = { "mode", fmt = function(str) return str:sub(1, 1) end }
      local workspace = {
        "workspace",
        on_click = function() vim.cmd("Telescope project") end,
        suffix = " on",
        separator = "",
      }
      local branch = {
        "branch",
        icon = Icon.git.Branch,
        on_click = function() vim.cmd("Telescope git_branches") end,
        padding = { left = 0, right = 1 },
      }
      local filename = {
        "filename",
        path = 0, --  0 = just filename, 1 = relative path, 2 = absolute path
        symbols = {
          modified = Icon.ui.DotFill,
          readonly = Icon.ui.Lock,
          unnamed = Icon.documents.File,
          newfile = Icon.documents.NewFile,
        },
      }
      local diagonostics = {
        "diagnostics",
        symbols = {
          error = Icon.diagnostics.Error .. " ",
          warn = Icon.diagnostics.Warn .. " ",
          info = Icon.diagnostics.Info .. " ",
          hint = Icon.diagnostics.Hint .. " ",
        },
        on_click = function() vim.cmd("Trouble diagnostics toggle filter.buf=0") end,
      }
      local git_blame_line = {
        "git_blame_line",
        padding = { right = 1 },
        icon = Icon.git.Commit,
        fmt = function(name)
          local w = vim.o.columns
          return strUtil.truncate(name, w > 172 and 80 or w > 112 and 48 or w > 92 and 24 or 0)
        end,
        separator = Icon.ui.Pipe,
      }
      local format_clients = {
        "format_clients",
        separator = "",
        padding = { left = 1, right = 0 },
        on_click = function() vim.cmd("ConformInfo") end,
      }
      local sidekick = {
        function() return " " end,
        separator = "",
        color = function()
          local status = require("sidekick.status").get()
          if status then
            return status.kind == "Error" and "DiagnosticError"
              or status.busy and "DiagnosticWarn"
              or "lualine_c_normal"
          end
        end,
        cond = function()
          local status = require("sidekick.status")
          return status.get() ~= nil
        end,
      }

      return {
        options = {
          globalstatus = true,
          component_separators = { left = Icon.ui.Pipe, right = Icon.ui.Pipe },
          section_separators = { left = Icon.ui.TriangleLeft, right = Icon.ui.TriangleRight },
          theme = custom_theme,
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            workspace,
            branch,
          },
          lualine_c = {
            filename,
            diagonostics,
          },
          lualine_x = {
            git_blame_line,
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              on_click = function() vim.cmd("Lazy") end,
            },
            { "inlay_hints" },
            format_clients,
            { "lsp_clients", padding = { left = 1, right = 0 } },
            sidekick,
          },
          lualine_y = {
            { "encoding", separator = "" },
            { "location", padding = { left = 0, right = 0 }, separator = "" },
            { "progress", padding = { left = 1, right = 1 }, separator = "" },
          },
          lualine_z = {},
        },
      }
    end,
  },
}
