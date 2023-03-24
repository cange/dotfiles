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
  Cut = " ", -- nf-fa-cut
  Dashboard = " ", -- nf-oct-dashboard
  Gear = " ", -- nf-oct-gear
  History = " ", -- nf-oct-history
  List = " ", -- nf-oct-list_unordered
  Lock = " ", -- nf-oct-lock
  Multiline = " ", -- nf-seti-project
  Note = " ",
  Octoface = " ", -- nf-oct-octoface
  Package = " ", -- nf-oct-package
  Question = " ", -- nf-oct-question
  Pencil = " ", -- nf-oct-pencil
  Pipe = "⏽ ", -- U+23FD
  PlusSmall = " ", -- nf-oct-plus_small
  Search = " ", -- nf-oct-search
  SignIn = " ", -- nf-oct-sign_in
  SignOut = " ", -- nf-oct-sign_out
  Stethoscope = " ",
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
  File = " ",
  Module = " ",
  Namespace = " ",
  Package = " ",
  Class = " ",
  Method = " ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = " ",
  Interface = " ",
  Function = " ",
  Variable = " ",
  Constant = " ",
  String = " ",
  Number = " ",
  Boolean = " ",
  Array = " ",
  Object = " ",
  Key = " ",
  Null = " ",
  EnumMember = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}
M.cmp_kinds = vim.tbl_extend("keep", kinds, {
  Color = " ",
  Folder = M.documents.Folder .. " ",
  Keyword = " ",
  Reference = " ",
  Snippet = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
})

M.cmp_source = {
  buffer = "﬘ ",
  luasnip = M.ui.Cut,
  nvim_lsp = " ",
  nvim_lua = " ",
  path = M.documents.Folder,
  cmp_tabnine = M.ui.Tabnine,
  copilot = M.ui.Octoface,
}

return M
