return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "EdenEast/nightfox.nvim",
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = {
          left = Cange.get_icon("ui.Pipe"),
          right = Cange.get_icon("ui.Pipe"),
        },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          { "branch", icon = Cange.get_icon("git.Branch") },
        },
        lualine_c = {
          {
            "diff",
            symbols = {
              added = Cange.get_icon("git.Add") .. " ",
              modified = Cange.get_icon("git.Mod") .. " ",
              removed = Cange.get_icon("git.Remove") .. " ",
            },
          },
          {
            "diagnostics",
            symbols = {
              error = Cange.get_icon("diagnostics.Error") .. " ",
              warn = Cange.get_icon("diagnostics.Warning") .. " ",
              info = Cange.get_icon("diagnostics.Information") .. " ",
              hint = Cange.get_icon("diagnostics.Hint") .. " ",
            },
          },
          {
            "filename",
            path = 1, -- 1: Relative path
            symbols = Cange.get_icon("lualine"),
          },
        },
        lualine_x = {
          require("cange.lualine.components.lazy_status"),
        },
        lualine_y = {
          { "filetype", icon_only = true },
          "fileformat",
          "encoding",
        },
        lualine_z = {
          "progress",
          "location",
        },
      },
    })
  end,
}
