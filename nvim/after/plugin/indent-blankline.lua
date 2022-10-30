local ns = "indent_blankline"
local found_indent_blankline, indent_blankline = pcall(require, "indent_blankline")
if not found_indent_blankline then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local icon = utils.get_icon
local found_colorscheme, colorscheme = pcall(require, "cange.colorscheme")
if not found_colorscheme then
  print("[" .. ns .. '] "cange.colorscheme" not found')
  return
end

indent_blankline.setup({
  enabled = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "dashboard",
    "packer",
    "NvimTree",
    "Trouble",
    "text",
  },
  char = icon("ui", "LineLeft"),
  context_char = icon("ui", "LineLeft"),
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
})
local found_palette, c = pcall(colorscheme.palette, nil)
if not found_palette or c == nil then
  return
end
utils.set_hls({
  IndentBlanklineChar = { fg = c.bg2 },
  IndentBlanklineContextChar = { fg = c.fg3 },
  IndentBlanklineContextStart = { sp = c.fg3, underline = true },
  IndentBlanklineSpaceChar = { fg = c.bg3 },
  IndentBlanklineSpaceCharBlankline = { fg = c.red.base },
})
