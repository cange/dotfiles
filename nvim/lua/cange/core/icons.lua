---@class Cange.core.Icons

---@type Cange.core.Icons
local m = {}

-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@enum Cange.core.Icons.ui
m.ui = {
  ArrowRight = "▸ ", -- U+25B8
  Beaker = " ", -- nf-oct-beaker
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
---@enum Cange.core.Icons.documents
m.documents = {
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
---@enum Cange.core.Icons.git
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
---@enum Cange.core.Icons.git_states
m.git_states = {
  unstaged = m.git.Mod,
  staged = "󱗜 ", -- nf-md-circle_box
  unmerged = " ", -- nf-cod-git_pull_request_draft
  renamed = m.git.Rename,
  untracked = m.ui.CircleUnfilled,
  deleted = m.git.Remove,
  ignored = m.git.Ignore,
}
---@enum Cange.core.Icons.diagnostics
m.diagnostics = {
  Error = " ", -- nf-oct-stop
  Warning = " ", -- nf-oct-alert
  Information = " ", -- nf-oct-info
  Question = " ", -- nf-oct-question
  Hint = " ", -- nf-oct-light_bulb
}
---@enum Cange.core.Icons.which_key
m.which_key = {
  Breadcrumb = " ", -- nf-oct-arrow_right
  Separator = m.ui.ChevronRight, -- symbol used between a key and it's label
  Group = " ", -- nf-oct-plus_small
}
---@enum Cange.core.Icons.kind
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
---@enum Cange.core.Icons.cmp_kind
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
---@enum Cange.core.Icons.cmp_source
m.cmp_source = {
  buffer = "﬘ ",
  luasnip = " ", -- nf-fa-cut
  nvim_lsp = " ",
  nvim_lua = " ",
  path = m.documents.Folder .. " ",
  cmp_tabnine = m.ui.Tabnine,
  copilot = m.ui.Octoface,
}
---@enum Cange.core.Icons.lualine
m.lualine = {
  modified = m.ui.Circle, -- Text to show when the file is modified.
  newfile = m.documents.NewFile, -- Text to show for new created file before first writting
  readonly = m.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = m.documents.File, -- Text to show for unnamed buffers.
}
---@enum Cange.core.Icons.mason
m.mason = {
  package_installed = m.ui.Check,
  package_pending = m.ui.Sync,
  package_uninstalled = m.ui.Close,
}

return m
