---@class Cange.core.icons
---@field cmp_kind table Completion kinds
---@field cmp_source table Completion sources
---@field diagnostics table
---@field git table
---@field git_states table
---@field kind table Language symbols
---@field lualine table
---@field mason table Mason LSP local anguage server plugin
---@field ui table Generic icons for general purposes
---@field which_key table
---@field documents table
--
---@type Cange.core.icons
local m = {}

-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

m.ui = {
  ArrowRight = "▸ ", -- U+25B8
  Bookmark = " ", -- nf-oct-bookmark
  Bug = " ", -- nf-oct-bug
  Calendar = " ", -- nf-oct-calendar
  Check = " ", -- nf-oct-check
  ChevronDown = " ", -- nf-oct-chevron_down
  ChevronRight = " ", -- nf-oct-chevron_right
  Circle = " ", -- nf-oct-pr{imitive_dot
  CircleUnfilled = " ", -- nf-cod-circle
  Close = " ", -- nf-oct-x
  Code = " ", -- nf-oct-code
  Comment = " ", -- nf-oct-comment
  Dashboard = " ", -- nf-oct-dashboard
  Gear = " ", -- nf-oct-gear
  History = " ", -- nf-oct-history
  List = " ", -- nf-oct-list_unordered
  Lock = " ", -- nf-oct-lock
  Multiline = " ", -- nf-seti-project
  Note = " ",
  Octoface = " ", -- nf-oct-octoface
  Package = " ", -- nf-oct-package
  Pencil = " ", -- nf-oct-pencil
  Pipe = "⏽ ", -- U+23FD
  Project = " ", -- nf-oct-repo
  Robot = "ﮧ ", -- nf-mdi-robot
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
  Workspace = " ", -- nf-oct-briefcase
}
m.documents = {
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
m.git = {
  Add = " ", -- nf-oct-diff_added,
  Mod = " ", -- nf-oct-diff_modified
  Remove = " ", -- nf-oct-diff_removed
  Ignore = " ", -- nf-oct-diff_ignored
  Rename = " ", -- nf-oct-diff_renamed
  Diff = " ", -- nf-oct-diff
  Branch = " ", -- nf-oct-git_branch
  Commit = " ", -- nf-oct-git_commit
}
m.git_states = {
  unstaged = m.git.Mod,
  staged = " ",
  unmerged = "ﱵ ",
  renamed = m.git.Rename,
  untracked = m.ui.CircleUnfilled,
  deleted = m.git.Remove,
  ignored = m.git.Ignore,
}
m.diagnostics = {
  Error = " ", -- nf-mdi-close_circle
  Warning = " ", -- nf-mdi-information_outline
  Information = " ", -- nf-mdi-information
  Question = "ﬤ ", -- nf-mdi-help_circle_outline
  Hint = " ", -- nf-mdi-lightbulb
}
m.which_key = {
  Breadcrumb = " ", -- nf-oct-arrow_right
  Separator = m.ui.ChevronRight, -- symbol used between a key and it's label
  Group = " ", -- nf-oct-plus_small
}
m.kind = {
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
m.cmp_kind = vim.tbl_extend("keep", m.kind, {
  Color = " ",
  Folder = m.documents.Folder .. " ",
  Keyword = " ",
  Reference = " ",
  Snippet = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
})
m.cmp_source = {
  buffer = "﬘ ",
  luasnip = " ", -- nf-fa-cut
  nvim_lsp = " ",
  nvim_lua = " ",
  path = m.documents.Folder .. " ",
  cmp_tabnine = m.ui.Tabnine,
  copilot = m.ui.Octoface,
}
m.lualine = {
  modified = m.ui.Circle, -- Text to show when the file is modified.
  newfile = m.documents.NewFile, -- Text to show for new created file before first writting
  readonly = m.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = m.documents.File, -- Text to show for unnamed buffers.
}
m.mason = {
  package_installed = m.ui.Check,
  package_pending = m.ui.Sync,
  package_uninstalled = m.ui.Close,
}

return m
