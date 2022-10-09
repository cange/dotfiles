---Provides the editors icons
---@class Icons
---@type table<string, table>
local M = {}
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---Generic icons for general purposes
---@enum ui
M.ui = {
  BigCircle = " ",
  BigUnfilledCircle = " ",
  Bookmark = " ",
  Bug = " ",
  Calendar = " ",
  Check = " ",
  ChevronDown = " ",
  ChevronRight = " ",
  Circle = " ",
  Close = " ",
  Code = " ",
  Comment = " ",
  Dashboard = " ",
  Fire = " ",
  Gear = " ",
  History = " ",
  Lightbulb = " ",
  LineLeft = "▏",
  List = " ",
  Lock = " ",
  Note = " ",
  Package = " ",
  Pencil = " ",
  Project = " ",
  Robot = "ﮧ ",
  Search = " ",
  SignIn = " ",
  SignOut = " ",
  Stethoscope = " ",
  Sync = " ",
  Tag = " ",
  Telescope = " ",
  Watch = " ",
  Workspace = " ",
}

---@enum documents
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

---@enum git
M.git = {
  Add = " ",
  Mod = " ",
  Remove = " ",
  Ignore = " ",
  Rename = " ",
  Diff = " ",
  Branch = " ",
  Octoface = " ",
}

---@enum diagnostics
M.diagnostics = {
  Error = " ",
  Warning = " ",
  Information = " ",
  Question = " ",
  Hint = " ",
}

---@enum which_key
M.which_key = {
  breadcrumb = "» ", -- symbol used in the command line area that shows your active key combo
  separator = M.ui.ChevronRight, -- symbol used between a key and it's label
  group = "+ ", -- symbol prepended to a group
}

---Language symbols
---@enum kind
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

---Completion kinds
---@enum cmp_kind
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

---@enum cmp_source
M.cmp_source = {
  buffer = "﬘ ",
  luasnip = "  ",
  nvim_lsp = " ",
  nvim_lua = " ",
  path = M.documents.Folder .. " ",
  tabnine = M.ui.Robot .. " ",
}

---@enum git_states
M.git_states = {
  unstaged = M.git.Mod,
  staged = "",
  unmerged = "ﱵ",
  renamed = M.git.Rename,
  untracked = "ﱡ",
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
}

---@enum lualine
M.lualine = {
  modified = M.ui.Circle, -- Text to show when the file is modified.
  newfile = M.documents.NewFile, -- Text to show for new created file before first writting
  readonly = M.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = M.documents.File, -- Text to show for unnamed buffers.
}

---Mason LSP local anguage server plugin
---@enum mason
M.mason = {
  package_installed = M.ui.Check,
  package_pending = M.ui.Sync,
  package_uninstalled = M.ui.Close,
}

return M
