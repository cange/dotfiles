return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "EdenEast/nightfox.nvim",
      "SmiteshP/nvim-navic",
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
            "mode",
          },
          lualine_b = {
            { "branch", icon = icon("git.Branch") },
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = icon("lualine"), separator = icon("ui.ChevronRight") },
            { require("nvim-navic").get_location, cond = require("nvim-navic").is_available },
          },
          lualine_x = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
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
          lualine_y = {
            {
              "diff",
              symbols = {
                added = icon("git.Add") .. " ",
                modified = icon("git.Mod") .. " ",
                removed = icon("git.Remove") .. " ",
              },
            },
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

  -- lsp symbol navigation
  {
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
