return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "folke/lazy.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local icon = Cange.get_icon

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
              fmt = function(mode)
                return string.sub(mode, 0, 1)
              end,
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
            },
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
            {
              "diff",
              symbols = {
                added = icon("git.Add") .. " ",
                modified = icon("git.Mod") .. " ",
                removed = icon("git.Remove") .. " ",
              },
            },
          },
          lualine_y = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
          },
          lualine_z = {
            { "fileformat", separator = "" },
            "encoding",
            { "progress", separator = "", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
      })
    end,
  },

  { "RRethy/vim-illuminate" }, -- Highlight the word under the cursor

  { -- winbar with LSP context symbols
    "utilyre/barbecue.nvim",
    name = "barbecue",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local p = Cange.palette
      require("barbecue").setup({
        theme = {
          normal = { bg = p.bg0, fg = p.fg3 },
          dirname = { fg = p.bg4 },
        },
        exclude_filetypes = { "gitcommit", "toggleterm", "help", "NvimTree" },
      })
    end,
  },

  { -- LSP context symbols
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
      require("nvim-navic").setup({
        icons = Cange.get_icon("kind"),
        highlight = true,
        separator = " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
      })
      vim.g.navic_silence = true
    end,
  },
}
