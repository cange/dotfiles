local i = Cange.get_icon

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
      local comp_icon = i("ui.Pipe")
      local sect_icon = ""
      require("lualine").setup({
        options = {
          component_separators = { left = comp_icon, right = comp_icon },
          section_separators = { left = sect_icon, right = sect_icon },
          globalstatus = true,
          refresh = { statusline = 2000 },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode) return string.sub(mode, 0, 1) end,
            },
          },
          lualine_b = {},
          lualine_c = {
            { "branch", icon = i("git.Branch") },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 0,
              symbols = {
                modified = i("ui.DotFill"),
                newfile = i("documents.NewFile"),
                readonly = i("ui.Lock"),
                unnamed = i("documents.File"),
              },
              separator = "",
              padding = { left = 1 },
            },
            { "git_blame_line", padding = { left = 2 }, icon = i("git.Commit") .. " " },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = i("diagnostics.Error") .. " ",
                warn = i("diagnostics.Warn") .. " ",
                info = i("diagnostics.Info") .. " ",
                hint = i("diagnostics.Hint") .. " ",
              },
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
            "copilot_status",
            { "fileformat", separator = "", padding = { left = 1, right = 0 } },
            { "encoding" },
            { "selectioncount" },
            { "progress", separator = "", padding = { left = 1, right = 0 } },
            { "location" },
          },
          lualine_y = {},
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
