local ns = "cange.lualine.init"
local found_lualine, lualine = pcall(require, "lualine")
if not found_lualine then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local icon = utils.get_icon
local found_config, config = pcall(require, "cange.lualine.config")
if not found_config then
  print("[" .. ns .. '] "cange.lualine.config" not found')
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
      { "branch", icon = icon("git", "Branch") },
      "diff",
      {
        "diagnostics",
        symbols = {
          error = icon("diagnostics", "Error"),
          warn = icon("diagnostics", "Warning"),
          info = icon("diagnostics", "Information"),
          hint = icon("diagnostics", "Hint"),
        },
      },
    },
    lualine_c = {},
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
