--- Provides the editors icons
local M = {}
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

M.which_key = {
  breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
  separator = '➜ ', -- symbol used between a key and it's label
  group = '+', -- symbol prepended to a group
}

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
M.cmp_source = {
  buffer = '﬘',
  nvim_lsp = '',
  nvim_lua = '',
  path = '',
}
M.type = {
  Array = '',
  Number = '',
  String = '',
  Boolean = '蘒',
  Object = '',
}
M.documents = {
  File = '',
  Files = '',
  Folder = '',
  OpenFolder = '',
}
M.git = {
  Add = '',
  Mod = '',
  Remove = '',
  Ignore = '',
  Rename = '',
  Diff = '',
  Repo = '',
  Octoface = '',
}
M.git_states = {
  staged = '',
  deleted = '',
  ignored = '',
  renamed = '',
  unmerged = 'ﱵ',
  unstaged = '',
  untracked = 'ﱡ',
}
M.mason = {
  package_installed = '',
  package_pending = '',
  package_uninstalled = '',
}
M.ui = {
  ArrowClosed = '',
  ArrowOpen = '',
  Lock = '',
  Circle = '',
  BigCircle = '',
  BigUnfilledCircle = '',
  Close = '',
  NewFile = '',
  Search = '',
  Lightbulb = '',
  Project = '',
  Dashboard = '',
  History = '',
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

M.diagnostics = {
  Error = '',
  Warning = '',
  Information = '',
  Question = '',
  Hint = '',
}
M.misc = {
  Robot = 'ﮧ',
  Squirrel = '',
  Tag = '',
  Watch = '',
  Smiley = 'ﲃ',
  Package = '',
  CircuitBoard = '',
}

return M
