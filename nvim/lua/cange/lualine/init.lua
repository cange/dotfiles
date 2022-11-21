local ns = "[cange.lualine]"
local found_lualine, lualine = pcall(require, "lualine")
if not found_lualine then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end
local found_config, config = pcall(require, "cange.lualine.config")
if not found_config then
  print(ns, '"cange.lualine.config" not found')
  return
end
-- config
lualine.setup({
  options = {
    component_separators = config.separators.strong,
    section_separators = config.separators.none,
  },
  sections = {
    lualine_b = {
      { "branch", icon = vim.trim(utils.get_icon("git", "Branch")) },
      "diff",
      {
        "diagnostics",
        symbols = {
          error = utils.get_icon("diagnostics", "Error"),
          warn = utils.get_icon("diagnostics", "Warning"),
          info = utils.get_icon("diagnostics", "Information"),
          hint = utils.get_icon("diagnostics", "Hint"),
        },
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1, -- 1: Relative path
        symbols = utils.get_icon("lualine"),
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
