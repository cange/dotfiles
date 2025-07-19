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

      return {
        options = {
          globalstatus = true,
          component_separators = { left = Icon.ui.Pipe, right = Icon.ui.Pipe },
          section_separators = { left = "", right = "" },
          theme = custom_theme,
        },
        sections = {
          lualine_a = {
            { "mode", fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = {},
          lualine_c = {
            {
              "workspace",
              on_click = function() vim.cmd("Telescope project") end,
              suffix = " on",
              separator = "",
            },
            {
              "branch",
              icon = Icon.git.Branch,
              on_click = function() vim.cmd("Telescope git_branches") end,
              padding = { left = 0, right = 1 },
            },
            {
              "diagnostics",
              symbols = {
                error = Icon.diagnostics.Error .. " ",
                warn = Icon.diagnostics.Warn .. " ",
                info = Icon.diagnostics.Info .. " ",
                hint = Icon.diagnostics.Hint .. " ",
              },
              on_click = function() vim.cmd("Trouble diagnostics toggle filter.buf=0") end,
            },
          },
          lualine_y = {},
          lualine_x = {
            {
              "git_blame_line",
              padding = { right = 1 },
              icon = Icon.git.Commit,
              fmt = function(name)
                local w = vim.o.columns
                return strUtil.truncate(name, w > 172 and 80 or w > 112 and 48 or w > 92 and 24 or 0)
              end,
              separator = Icon.ui.Pipe,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              on_click = function() vim.cmd("Lazy") end,
            },
            { "inlay_hints" },
            {
              "format_clients",
              separator = "",
              padding = { left = 1, right = 0 },
              on_click = function() vim.cmd("ConformInfo") end,
            },
            { "lsp_clients", padding = { left = 1, right = 0 } },
            {
              "copilot",
              on_click = function() vim.cmd("Copilot status") end,
              padding = { left = 1, right = 0 },
              separator = "",
              symbols = { spinners = vim.split(Icon.sets.spinner, " ") },
            },
            {
              "mcphub",
              padding = { left = 1, right = 0 },
              on_click = function() vim.cmd("MCPHub") end,
            },
            { "encoding", separator = "" },
            { "location", padding = { left = 0, right = 0 }, separator = "" },
            { "progress", padding = { left = 1, right = 0 }, separator = "" },
          },
          lualine_z = {},
        },
      }
    end,
  },

  { -- winbar with LSP context symbols
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    opts = { icons = { kinds = { symbols = { Folder = "" } } } },
    event = "BufEnter",
    keys = function() return { { "<Leader>;", require("dropbar.api").pick, desc = "Pick symbols in winbar" } } end,
  },
}
