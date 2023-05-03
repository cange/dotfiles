local icon = Cange.get_icon

---@type cange.colorschemePalette
local p = Cange.get_config("ui.palette")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      ---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

      local copilot_status = {
        function()
          ---@type copilot_status_notification_data
          local data = require("copilot.api").status.data
          local msg = data.message or ""
          return (msg and #msg > 0 and msg .. " " or "") .. icon("ui.Octoface") .. " "
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          local colors = {
            [""] = Cange.fg("lualine_c_inactive"),
            ["Normal"] = Cange.fg("lualine_c_normal"),
            ["Warning"] = Cange.fg("lualine_c_diagnostics_warn_normal"),
            ["InProgress"] = Cange.fg("lualine_c_diagnostics_info_normal"),
          }
          ---@type copilot_status_notification_data
          local data = require("copilot.api").status.data
          return colors[data.status] or colors[""]
        end,
      }
      require("lualine").setup({
        options = {
          component_separators = {
            left = icon("ui.Pipe"),
            right = icon("ui.Pipe"),
          },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode) return string.sub(mode, 0, 1) end,
            },
          },
          lualine_b = {
            { "branch", icon = icon("git.Branch") },
          },
          lualine_c = {
            { require("auto-session.lib").current_session_name },
            {
              "diagnostics",
              symbols = {
                error = icon("diagnostics.Error") .. " ",
                warn = icon("diagnostics.Warn") .. " ",
                info = icon("diagnostics.Info") .. " ",
                hint = icon("diagnostics.Hint") .. " ",
              },
            },
          },
          lualine_x = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
            copilot_status,
          },
          lualine_y = {
            { "fileformat", separator = "", padding = { left = 1, right = 0 } },
            "encoding",
          },
          lualine_z = {
            "selectioncount",
            { "progress", separator = "" },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
      })
    end,
  },

  { -- winbar with LSP context symbols
    "utilyre/barbecue.nvim",
    name = "barbecue",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = {
        basename = { fg = p.fg2 },
        dirname = { fg = p.fg2 },
        normal = { fg = p.fg3, bg = p.bg0 },
        modified = { fg = p.fg1 },
      },
      show_modified = true,
      exclude_filetypes = { "gitcommit", "toggleterm", "help", "NvimTree" },
    },
  },
}
