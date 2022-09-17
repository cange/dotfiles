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
---@type table<string, string>
M.ui = {
  ArrowClosed = '',
  ArrowOpen = '',
  Lock = '',
  Circle = '',
  BigCircle = '',
  BigUnfilledCircle = '',
  Close = '',
  NewFile = '',
  Search = '',
  Lightbulb = '',
  Project = '',
  Dashboard = '',
  History = '',
  Comment = '',
  Bug = '',
  Code = '',
  Telescope = '',
  Gear = '',
  Package = '',
  List = '',
  SignIn = '',
  SignOut = '',
  Check = '',
  Fire = '',
  Note = '',
  BookMark = '',
  Pencil = '',
  ChevronRight = '',
  Table = '',
  Calendar = '',
  CloudDownload = '',
}

---@type table<string, string>
M.misc = {
  Robot = 'ﮧ',
  Squirrel = '',
  Tag = '',
  Watch = '',
  Smiley = 'ﲃ',
  Package = '',
  CircuitBoard = '',
  Workspace = '',
}

---Language types
---@type table<string, string>
M.type = {
  Array = '',
  Number = '',
  String = '',
  Boolean = '蘒',
  Object = '',
}

---@type table<string, string>
M.documents = {
  File = '',
  Files = '',
  Folder = '',
  OpenFolder = '',
}

---@type table<string, string>
M.git = {
  Add = '',
  Mod = '',
  Remove = '',
  Ignore = '',
  Rename = '',
  Diff = '',
  Repo = '',
  Octoface = '',
}
--[[

Plugin related icons

]]
---@type table<string, string>
M.diagnostics = {
  Error = '',
  Warning = '',
  Information = '',
  Question = '',
  Hint = '',
}

---Which-key plugin
---@type table<string, string>
M.which_key = {
  breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
  separator = '➜ ', -- symbol used between a key and it's label
  group = '+', -- symbol prepended to a group
}

---Language node items
---@type table<string, string>
M.kind = {
  Text = '',
  Method = 'm',
  Function = '',
  Constructor = '',
  Field = 'ﰠ',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

---Completion sources
---@type table<string, string>
M.cmp_source = {
  buffer = '﬘',
  nvim_lsp = '',
  nvim_lua = '',
  path = M.documents.Folder,
}

---@type table<string, string>
M.git_states = {
  staged = '',
  deleted = M.git.Remove,
  ignored = M.git.Ignore,
  renamed = M.git.Rename,
  unmerged = 'ﱵ',
  unstaged = M.git.Mod,
  untracked = 'ﱡ',
}

---@type table<string, string>
M.lualine = {
  unnamed = M.documents.File, -- Text to show for unnamed buffers.
  readonly = M.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  modified = M.ui.Circle, -- Text to show when the file is modified.
  newfile = '', -- Text to show for new created file before first writting
}

---Mason LSP local anguage server plugin
---@type table<string, string>
M.mason = {
  package_installed = '',
  package_pending = '',
  package_uninstalled = '',
}

return M
