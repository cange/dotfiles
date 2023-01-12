local found_lazy, lazy_status = pcall(require, "lazy.status")
local lazy_status_component = {}
if found_lazy then
  lazy_status_component = {
    lazy_status.updates,
    cond = lazy_status.has_updates,
    color = { fg = "#ff9e64" },
  }
end

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
          "filetype",
          "fileformat",
          lazy_status_component,
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
