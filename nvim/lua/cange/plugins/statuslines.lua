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
            require("cange.utils.copilot").lualine_status,
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
