-- local ns = "[plugin/indent_blankline]"
local found_indent_blankline, indent_blankline = pcall(require, "indent_blankline")
if not found_indent_blankline then
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
  char = Cange.get_icon("ui", "LineLeft"),
  context_char = Cange.get_icon("ui", "LineLeft"),
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
})
