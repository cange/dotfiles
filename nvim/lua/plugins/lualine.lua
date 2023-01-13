return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { left = "⏽", right = "⏽" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = {
          { "branch", icon = Cange.get_icon("git.Branch", { trim = true }) },
          "diff",
          {
            "diagnostics",
            symbols = {
              error = Cange.get_icon("diagnostics.Error"),
              warn = Cange.get_icon("diagnostics.Warning"),
              info = Cange.get_icon("diagnostics.Information"),
              hint = Cange.get_icon("diagnostics.Hint"),
            },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 1: Relative path
            symbols = Cange.get_icon("lualine"),
          },
        },
        lualine_x = {
          require("cange.lualine.components.lazy_status"),
          "filetype",
          "fileformat",
        },
        lualine_y = { "encoding" },
        lualine_z = {
          "progress",
          "location",
        },
      },
    })
  end,
}
