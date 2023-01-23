---@class IconGroup
---@field cmp_kind table<string, string> Completion kinds
---@field cmp_source table<string, string>
---@field diagnostics table<string, string>
---@field git table<string, string>
---@field git_states table<string, string>
---@field kind table<string, string> Language symbols
---@field lualine table<string, string>
---@field mason table<string, string> Mason LSP local anguage server plugin
---@field ui table Generic icons for general purposes
---@field which_key table<string, string>
---@field documents table<string, string>

---@class IconGroup
local M = {}
-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@enum IconGroup.ui
M.ui = {
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

---@enum IconGroup.documents
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

---@enum IconGroup.git
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

---@enum IconGroup.git_states
M.git_states = {
  unstaged = M.git.Mod,
  staged = " ",
  unmerged = "ﱵ ",
  renamed = M.git.Rename,
  untracked = M.ui.CircleUnfilled,
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
}

---@enum IconGroup.diagnostics
M.diagnostics = {
  Error = " ", -- nf-mdi-close_circle
  Warning = " ", -- nf-mdi-information_outline
  Information = " ", -- nf-mdi-information
  Question = "ﬤ ", -- nf-mdi-help_circle_outline
  Hint = " ", -- nf-mdi-lightbulb
}

---@enum IconGroup.which_key
M.which_key = {
  Breadcrumb = " ", -- nf-oct-arrow_right
  Separator = M.ui.ChevronRight, -- symbol used between a key and it's label
  Group = " ", -- nf-oct-plus_small
}

---@enum IconGroup.kind
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

---@enum IconGroup.cmp_kind
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

---@enum IconGroup.cmp_source
M.cmp_source = {
  buffer = "﬘ ",
  luasnip = " ", -- nf-fa-cut
  nvim_lsp = " ",
  nvim_lua = " ",
  path = M.documents.Folder .. " ",
  cmp_tabnine = M.ui.Tabnine,
  copilot = M.ui.Octoface,
}

---@enum IconGroup.lualine
M.lualine = {
  modified = M.ui.Circle, -- Text to show when the file is modified.
  newfile = M.documents.NewFile, -- Text to show for new created file before first writting
  readonly = M.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = M.documents.File, -- Text to show for unnamed buffers.
}

---@enum IconGroup.mason
M.mason = {
  package_installed = M.ui.Check,
  package_pending = M.ui.Sync,
  package_uninstalled = M.ui.Close,
}

return M
