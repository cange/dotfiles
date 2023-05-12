local icon = Cange.get_icon

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
      local comp_icon = icon("ui.Pipe")
      local sect_icon = ""
      require("lualine").setup({
        options = {
          component_separators = { left = comp_icon, right = comp_icon },
          section_separators = { left = sect_icon, right = sect_icon },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode) return string.sub(mode, 0, 1) end,
            },
          },
          lualine_b = {
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
          lualine_c = {
            { "branch", icon = icon("git.Branch") },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 0,
              symbols = {
                modified = icon("ui.DotFill"),
                newfile = icon("documents.NewFile"),
                readonly = icon("ui.Lock"),
                unnamed = icon("documents.File"),
              },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_x = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
            { require("auto-session.lib").current_session_name },
            "copilot_status",
          },
          lualine_y = {
            { "fileformat", separator = "", padding = { left = 1, right = 0 } },
            { "encoding" },
            { "selectioncount" },
            { "progress", separator = "", padding = { left = 1, right = 0 } },
            { "location" },
          },
          lualine_z = {},
        },
      })
    end,
  },

  { -- winbar with LSP context symbols
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      require("barbecue").setup({
        theme = {
          dirname = Cange.get_hl("lualine_c_inactive", { "fg" }),
          normal = Cange.get_hl("lualine_c_normal"),
          modified = Cange.get_hl("lualine_c_normal", { "fg" }),
          basename = Cange.get_hl("lualine_c_normal", { "fg" }),
        },
        show_modified = true,
        exclude_filetypes = { "gitcommit", "toggleterm", "help", "NvimTree" },
      })
    end,
  },
}
