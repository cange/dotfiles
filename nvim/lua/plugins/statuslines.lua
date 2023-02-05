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
      local function navic_status()
        return { require("nvim-navic").get_location, cond = require("nvim-navic").is_available }
      end

      local function lazy_status()
        return { require("lazy.status").updates, cond = require("lazy.status").has_updates }
      end

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
            navic_status(),
          },
          lualine_x = {
            lazy_status(),
          },
          lualine_y = {
            {
              "diagnostics",
              symbols = {
                error = icon("diagnostics.Error") .. " ",
                warn = icon("diagnostics.Warning") .. " ",
                info = icon("diagnostics.Information") .. " ",
                hint = icon("diagnostics.Hint") .. " ",
              },
            },
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
