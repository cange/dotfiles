-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@class cange.iconGroup[]
local M = {}

M.ui = {
  ArrowRight = "▸ ", -- U+25B8
  Beaker = " ", -- nf-oct-beaker
  Bookmark = " ", -- nf-oct-bookmark
  Bug = " ", -- nf-oct-bug
  Calendar = " ", -- nf-oct-calendar
  Check = " ", -- nf-oct-check
  ChevronDown = " ", -- nf-oct-chevron_down
  ChevronRight = " ", -- nf-oct-chevron_right
  Circle = " ", -- nf-oct-primitive_dot
  CircleUnfilled = " ", -- nf-cod-circle
  Close = " ", -- nf-oct-x
  Code = " ", -- nf-oct-code
  Comment = " ", -- nf-oct-comment
  Copilot = " ", -- nf-oct-copilot
  CopilotError = " ", --nf-oct-copilot_error
  CopilotWarning = " ", -- nf-oct-copilot_warning
  Cut = " ", -- nf-fa-cut
  Dashboard = " ", -- nf-oct-dashboard
  Gear = " ", -- nf-oct-gear
  History = " ", -- nf-oct-history
  List = " ", -- nf-oct-list_unordered
  Lock = " ", -- nf-oct-lock
  Multiline = " ", -- nf-seti-project
  Note = " ",
  Octoface = " ", -- nf-cod-octoface
  Package = " ", -- nf-oct-package
  Question = " ", -- nf-oct-question
  Pencil = " ", -- nf-oct-pencil
  Pipe = "⏽ ", -- U+23FD
  PlusSmall = " ", -- nf-oct-plus_small
  Search = " ", -- nf-oct-search
  SignIn = " ", -- nf-oct-sign_in
  SignOut = " ", -- nf-oct-sign_out
  Stethoscope = " ",
  Stop = " ", -- nf-oct-circle_slash
  Sync = " ", -- nf-oct-sync
  Tabnine = "⌬ ", -- U+232C
  Tag = " ", -- nf-oct-tag
  Telescope = " ", -- nf-oct-telescope
  VDashLineLeft = "┆ ", -- U+2506
  VDotLineLeft = "┊ ", --U+250A
  VLineLeft = "▎ ", -- U+258E
  VThinLineLeft = "▏ ", -- U+258F
  Watch = " ", -- nf-oct-clock
}
M.documents = {
  Briefcase = " ", -- nf-oct-briefcase
  EmptyFolder = " ", -- nf-fa-folder_o
  EmptyOpenFolder = " ", -- nf-fa-folder_open_o
  File = " ", --nf-cod-file
  Files = " ", -- nf-cod-files
  Folder = " ", -- nf-fa-folder
  NewFile = " ", -- nf-cod-new_file
  OpenFolder = " ", --  nf-fa-folder_open
  Repo = " ", -- nf-oct-repo
  SymlinkFile = " ", --nf-cod-file_symlink_file
  SymlinkFolder = " ", --nf-cod-file_symlink_directory
}
M.sets = {
  bulbs = "󱩎 󱩏 󱩐 󱩑 󱩒 󱩓 󱩔 󱩕 󱩖 󰛨", -- nf-md-lightbulb_[on_outline|10-90|on]
  batteries = "󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰂀 󰂁 󰂂 󰁹", -- nf-md-battery_[outline|10-90|]
}
M.git = {
  Add = " ", -- nf-oct-diff_added,
  Mod = " ", -- nf-oct-diff_modified
  Remove = " ", -- nf-oct-diff_removed
  Ignore = " ", -- nf-oct-diff_ignored
  Rename = " ", -- nf-oct-diff_renamed
  Diff = " ", -- nf-oct-diff
  Branch = " ", -- nf-oct-git_branch
  Commit = " ", -- nf-oct-git_commit
}
M.git_states = {
  unstaged = M.git.Mod,
  staged = "", -- none on purpose
  unmerged = " ", -- nf-cod-git_pull_request_draft
  renamed = M.git.Rename,
  untracked = M.ui.CircleUnfilled,
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
}
M.diagnostics = {
  Error = " ", -- nf-oct-stop
  Warn = " ", -- nf-oct-alert
  Info = " ", -- nf-oct-info
  Hint = " ", -- nf-oct-light_bulb
}
local kinds = {
  File = " ", -- nf-cod-symbol_file
  Module = " ", -- nf-cod-symbol_namespace
  Namespace = " ", -- nf-cod-symbol_namespace
  Package = " ", -- nf-cod-package
  Class = " ", -- nf-cod-symbol_class
  Method = " ", -- nf-cod-symbol_method
  Property = " ", -- nf-cod-symbol_property
  Field = " ", -- nf-cod-symbol_field
  Constructor = " ", -- nf-cod-symbol_method
  Enum = " ", -- nf-cod-symbol_enum
  Interface = " ", -- nf-cod-symbol_interface
  Function = " ", -- nf-cod-symbol_method
  Variable = " ", -- nf-cod-symbol_variable
  Constant = " ", -- nf-cod-symbol_constant
  String = " ", -- nf-cod-symbol_string
  Number = " ", -- nf-cod-symbol_numeric
  Boolean = " ", -- nf-cod-symbol_boolean
  Array = " ", -- nf-cod-symbol_array
  Object = " ", -- nf-cod-symbol_namespace
  Key = " ", -- nf-cod-symbol_key
  Null = "󰟢 ", -- nf-md-null
  EnumMember = " ", -- nf-cod-symbol_enum_member
  Struct = " ", -- nf-cod-symbol_structure
  Event = " ", -- nf-cod-symbol_event
  Operator = " ", -- nf-cod-symbol_operator
  TypeParameter = " ", -- nf-cod-symbol_parameter
  Misc = " ", -- nf-cod-symbol_misc
}

M.cmp_kinds = vim.tbl_extend("keep", kinds, {
  Color = " ", -- nf-cod-symbol_color
  Folder = M.documents.Folder,
  Keyword = " ", -- nf-cod-symbol_keyword
  Reference = " ", -- nf-oct-file_symlink_file
  Snippet = " ", -- nf-cod-symbol_snippet
  Text = "󰉿 ", -- nf-md-format_size
  Unit = " ", -- nf-cod-symbol_ruler
  Value = "󰎠 ", -- nf-md-numeric
})

M.cmp_source = {
  buffer = " ", -- nf-oct-stack
  cmp_tabnine = M.ui.Tabnine,
  copilot = M.ui.Copilot,
  luasnip = M.ui.Cut,
  nvim_lsp = " ", -- nf-oct-book
  nvim_lua = " ", -- nf-seti-lua
  path = M.documents.Folder,
}

return M
