local icon = Cange.get_icon

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = {
          left = icon("ui.Pipe", { trim = true }),
          right = icon("ui.Pipe", { trim = true }),
        },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = {
          { "branch", icon = icon("git.Branch", { trim = true }) },
          {
            "diff",
            symbols = {
              added = icon("git.Add"),
              modified = icon("git.Mod"),
              removed = icon("git.Remove"),
            },
          },
          {
            "diagnostics",
            symbols = {
              error = icon("diagnostics.Error"),
              warn = icon("diagnostics.Warning"),
              info = icon("diagnostics.Information"),
              hint = icon("diagnostics.Hint"),
            },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 1: Relative path
            symbols = icon("lualine"),
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
