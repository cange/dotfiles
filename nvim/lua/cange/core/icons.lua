---@alias cange.core.Icon string A single character of a certain shape

---@class cange.core.Icons
---@field cmp_kind table<cange.core.Icon> Completion kinds
---@field cmp_source table<cange.core.Icon>
---@field diagnostics table<cange.core.Icon>
---@field git table<cange.core.Icon>
---@field git_states table<cange.core.Icon>
---@field kind table<cange.core.Icon> Language symbols
---@field lualine table<cange.core.Icon>
---@field mason table<cange.core.Icon> Mason LSP local anguage server plugin
---@field ui table Generic icons for general purposes
---@field which_key table<cange.core.Icon>
---@field documents table<cange.core.Icon>

local M = {}
-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

M.ui = {
  BigCircle = " ",
  BigUnfilledCircle = " ",
  Bookmark = " ", -- nf-oct-bookmark
  Bug = " ", -- nf-oct-bug
  Calendar = " ", -- nf-oct-calendar
  Check = " ", -- nf-oct-check
  ChevronDown = " ", -- nf-oct-chevron_down
  ChevronRight = " ", -- nf-oct-chevron_right
  Circle = " ", -- nf-oct-primitive_dot
  Close = " ", -- nf-oct-x
  Code = " ", -- nf-oct-code
  Comment = " ", -- nf-oct-comment
  Dashboard = " ", -- nf-oct-dashboard
  Gear = " ", -- nf-oct-gear
  History = " ", -- nf-oct-history
  LineLeft = "▏",
  List = " ", -- nf-oct-list_unordered
  Lock = " ", -- nf-oct-lock
  Note = " ",
  Multiline = " ", -- nf-seti-project
  Package = " ", -- nf-oct-package
  Pencil = " ", -- nf-oct-pencil
  Project = " ", -- nf-oct-repo
  Robot = "ﮧ ", -- nf-mdi-robot
  Search = " ", -- nf-oct-search
  SignIn = " ", -- nf-oct-sign_in
  SignOut = " ", -- nf-oct-sign_out
  Stethoscope = " ",
  Sync = " ", -- nf-oct-sync
  Tag = " ", -- nf-oct-tag
  Telescope = " ", -- nf-oct-telescope
  Watch = " ", -- nf-oct-clock
  Workspace = " ", -- nf-oct-briefcase
}
M.documents = {
  NewFile = " ",
  EmptyFolder = " ",
  EmptyOpenFolder = " ",
  File = " ",
  Files = " ",
  Folder = " ",
  OpenFolder = " ",
  SymlinkFile = " ",
  SymlinkFolder = " ",
}
M.git = {
  Add = " ", -- nf-oct-diff_added,
  Mod = " ", -- nf-oct-diff_modified
  Remove = " ", -- nf-oct-diff_removed
  Ignore = " ", -- nf-oct-diff_ignored
  Rename = " ", -- nf-oct-diff_renamed
  Diff = " ", -- nf-oct-diff
  Branch = " ", --nf-oct-git_branch
  Octoface = " ", -- nf-oct-octoface
}
M.diagnostics = {
  Error = " ", -- nf-mdi-close_circle
  Warning = " ", -- nf-mdi-information_outline
  Information = " ", -- nf-mdi-information
  Question = "ﬤ ", -- nf-mdi-help_circle_outline
  Hint = " ", -- nf-mdi-lightbulb
}
M.which_key = {
  breadcrumb = " ", -- nf-oct-arrow_right
  separator = M.ui.ChevronRight, -- symbol used between a key and it's label
  group = " ", -- nf-oct-plus_small
}
M.kind = {
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
M.cmp_kind = vim.tbl_extend("keep", M.kind, {
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
  luasnip = " ", -- nf-fa-cut
  nvim_lsp = " ",
  nvim_lua = " ",
  path = M.documents.Folder .. " ",
  cmp_tabnine = M.ui.Robot .. " ",
}
M.git_states = {
  unstaged = M.git.Mod,
  staged = " ",
  unmerged = "ﱵ ",
  renamed = M.git.Rename,
  untracked = "ﱡ ",
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
}
M.lualine = {
  modified = M.ui.Circle, -- Text to show when the file is modified.
  newfile = M.documents.NewFile, -- Text to show for new created file before first writting
  readonly = M.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = M.documents.File, -- Text to show for unnamed buffers.
}
M.mason = {
  package_installed = M.ui.Check,
  package_pending = M.ui.Sync,
  package_uninstalled = M.ui.Close,
}

return M
