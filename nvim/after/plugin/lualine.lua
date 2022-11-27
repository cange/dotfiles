local ns = "[plugin/lualine]"
local found_lualine, lualine = pcall(require, "lualine")
if not found_lualine then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end

---@param type string
---@return table
local function seperator_preset(type)
  ---@enumn separators
  local seps = {
    arrow_component = { left = "", right = "" },
    arrow_section = { left = "", right = "" },
    line_component = { left = "│", right = "│" },
    line_section = { left = "", right = "" },
    none_component = { left = "", right = "" },
    none_section = { left = "", right = "" },
    pill_component = { left = "", right = "" },
    pill_section = { left = "", right = "" },
    pipe_component = { left = "⏽", right = "⏽" },
    pipe_section = { left = "", right = "" },
    triangle_component = { left = "", right = "" },
    triangle_section = { left = "", right = "" },
  }
  return {
    component_separators = seps[type .. "_component"],
    section_separators = seps[type .. "_section"],
  }
end
-- config
lualine.setup({
  options = seperator_preset("line"),
  sections = {
    lualine_b = {
      { "branch", icon = utils.get_icon("git", "Branch", { trim = true }) },
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
