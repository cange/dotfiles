return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "EdenEast/nightfox.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-navic",
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
          {
            "diff",
            symbols = {
              added = icon("git.Add") .. " ",
              modified = icon("git.Mod") .. " ",
              removed = icon("git.Remove") .. " ",
            },
          },
          {
            "diagnostics",
            symbols = {
              error = icon("diagnostics.Error") .. " ",
              warn = icon("diagnostics.Warning") .. " ",
              info = icon("diagnostics.Information") .. " ",
              hint = icon("diagnostics.Hint") .. " ",
            },
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = icon("lualine"), separator = "" },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          require("cange.lualine.components.lazy_status"),
        },
        lualine_y = {
          { "fileformat", separator = "" },
          "encoding",
        },
        lualine_z = {
          { "progress", separator = "", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    })
  end,
}
