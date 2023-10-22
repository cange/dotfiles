local i = Cange.get_icon

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        component_separators = { left = i("ui.Pipe"), right = i("ui.Pipe") },
        section_separators = { left = i("ui.TriangleLowerLeft") .. " ", right = i("ui.TriangleUpperRight") .. " " },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode", fmt = function(mode) return string.sub(mode, 0, 1) end, separator = i("ui.VThinLineLeft") },
          { "branch", icon = i("git.Branch") },
        },
        lualine_b = {
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
          },
        },
        lualine_c = {
          { "git_blame_line", padding = { left = 1 }, icon = i("git.Commit") },
        },
        lualine_x = {
          "lsp_progress",
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
          "lsp_status",
        },
        lualine_y = {
          "format_status",
          "copilot_status",
          {
            "progress",
            separator = "",
            padding = { left = 1, right = 0 },
          },
          "location",
          {
            function() return i("ui.Tab") .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth") end,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          "encoding",
        },
        lualine_z = {},
      },
    },
  },

  { -- winbar with LSP context symbols
    "utilyre/barbecue.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        theme = {
          modified = Cange.get_hl("lualine_c_normal", { "fg" }),
          basename = Cange.get_hl("lualine_c_normal", { "fg" }),
        },
        symbols = {
          modified = i("ui.DotFill"),
          separator = i("ui.ChevronRight"),
        },
        show_modified = true,
        exclude_filetypes = { "gitcommit", "toggleterm", "help", "NvimTree" },
      })
    end,
  },
}
