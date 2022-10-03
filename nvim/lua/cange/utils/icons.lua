---Provides the editors icons
---@class Icons
---@type table<string, table>
local M = {}
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

--[[

Essential icons

]]
---@enum ui
M.ui = {
  ArrowClosed = '',
  ArrowOpen = '',
  Lock = '',
  Circle = '',
  BigCircle = '',
  BigUnfilledCircle = '',
  Close = '',
  Search = '',
  Lightbulb = '',
  Project = '',
  Dashboard = '',
  History = '',
  Comment = '',
  Bug = '',
  Code = '',
  Telescope = '',
  Gear = '',
  Package = '',
  List = '',
  SignIn = '',
  SignOut = '',
  Check = '',
  Fire = '',
  Note = '',
  BookMark = '',
  Pencil = '',
  ChevronRight = '',
  Table = '',
  Calendar = '',
  CloudDownload = '',
}

---@enum misc
M.misc = {
  ArrowRight = '',
  CircuitBoard = '',
  Package = '',
  Robot = 'ﮧ',
  Smiley = 'ﲃ',
  Squirrel = '',
  Stethoscope = '',
  Tag = '',
  Watch = '',
  Workspace = '',
}

---@enum documents
M.documents = {
  File = '',
  Files = '',
  Folder = '',
  OpenFolder = '',
}

---@enum git
M.git = {
  Add = '',
  Mod = '',
  Remove = '',
  Ignore = '',
  Rename = '',
  Diff = '',
  Repo = '',
  Octoface = '',
}
--[[

Plugin related icons

]]
---@enum diagnostics
M.diagnostics = {
  Error = '',
  Warning = '',
  Information = '',
  Question = '',
  Hint = '',
}

---@enum which_key
M.which_key = {
  breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
  separator = '', -- symbol used between a key and it's label
  group = '+', -- symbol prepended to a group
}

---Language types
M.type = {
  Array = '',
  Boolean = '◩',
  Function = '', -- '',
  Number = '', -- '',
  Null = ' ',
  Object = '',
  String = '', -- '',
}

---Language symbols
---@enum kind
M.kind = vim.tbl_extend('keep', M.type, {
  File = ' ',
  Module = '',
  Namespace = ' ',
  Package = ' ',
  Class = ' ',
  Method = '',
  Property = '',
  Field = '',
  Constructor = '',
  Enum = ' ',
  Interface = ' ',
  Variable = ' ',
  Constant = ' ',
  Key = '',
  EnumMember = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
  Color = '',
  Folder = M.documents.Folder,
  Keyword = '',
  Reference = '',
  Snippet = '',
  Text = '',
  Unit = '',
  Value = '',
})

---@enum cmp_source
M.cmp_source = {
  buffer = '﬘',
  nvim_lsp = 'ﮂ',
  nvim_lua = '',
  path = M.documents.Folder,
}

---@enum git_states
M.git_states = {
  unstaged = M.git.Mod,
  staged = '',
  unmerged = 'ﱵ',
  renamed = M.git.Rename,
  untracked = 'ﱡ',
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
}

---@enum lualine
M.lualine = {
  unnamed = M.documents.File, -- Text to show for unnamed buffers.
  readonly = M.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  modified = M.ui.Circle, -- Text to show when the file is modified.
  newfile = '', -- Text to show for new created file before first writting
}

---Mason LSP local anguage server plugin
---@enum mason
M.mason = {
  package_installed = '',
  package_pending = '',
  package_uninstalled = '',
}

return M
