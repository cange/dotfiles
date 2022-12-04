local ns = "[plugin/lualine]"
local found_lualine, lualine = pcall(require, "lualine")
if not found_lualine then
  return
end

-- config
lualine.setup({
  options = Cange.get_statusline_separator_preset(Cange.get_config("statusline.separator_type")),
  sections = {
    lualine_b = {
      { "branch", icon = Cange.get_icon("git", "Branch", { trim = true }) },
      "diff",
      {
        "diagnostics",
        symbols = {
          error = Cange.get_icon("diagnostics", "Error"),
          warn = Cange.get_icon("diagnostics", "Warning"),
          info = Cange.get_icon("diagnostics", "Information"),
          hint = Cange.get_icon("diagnostics", "Hint"),
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
    },
    lualine_y = { "encoding" },
    lualine_z = {
      "progress",
      "location",
    },
  },
})
