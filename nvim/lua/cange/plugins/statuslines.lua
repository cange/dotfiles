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
      {
        "jonahgoldwastaken/copilot-status.nvim",
        dependencies = "zbirenbaum/copilot.lua",
        lazy = true,
        event = "BufReadPost",
        config = function()
          require("copilot_status").setup({
            icons = {
              idle = icon("ui.Octoface"),
              error = icon("diagnostics.Error"),
              warning = icon("diagnostics.Warn"),
              loading = icon("ui.Sync"),
              offline = icon("ui.Stop"),
            },
          })
        end,
      },
    },
    config = function()
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
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 0,
              symbols = {
                modified = icon("ui.Circle"),
                newfile = icon("documents.NewFile"),
                readonly = icon("ui.Lock"),
                unnamed = icon("documents.File"),
              },
              separator = "",
            },
            {
              "diagnostics",
              symbols = {
                error = icon("diagnostics.Error") .. " ",
                warn = icon("diagnostics.Warn") .. " ",
                info = icon("diagnostics.Info") .. " ",
                hint = icon("diagnostics.Hint") .. " ",
              },
              -- padding = { left = 0 },
            },
          },
          lualine_x = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
          },
          lualine_y = {
            require("copilot_status").status_string,
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
      },
      exclude_filetypes = { "gitcommit", "toggleterm", "help", "NvimTree" },
    },
  },
}
