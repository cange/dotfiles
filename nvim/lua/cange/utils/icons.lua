--#region Types

---@class Icons
---@field ui table Generic icons for general purposes
---@filed documents table
---@field git table
---@field diagnostics table
---@field which_key table
---@field kind table Language symbols
---@field cmp_kind table Completion kinds
---@field cmp_source table
---@field git_states table
---@field lualine table
---@field mason table Mason LSP local anguage server plugin

--#endregion

local icons = {}
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

icons.ui = {
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
icons.documents = {
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
icons.git = {
  Add = " ",
  Mod = " ",
  Remove = " ",
  Ignore = " ",
  Rename = " ",
  Diff = " ",
  Branch = " ",
  Octoface = " ",
}
icons.diagnostics = {
  Error = " ",
  Warning = " ",
  Information = " ",
  Question = " ",
  Hint = " ",
}
icons.which_key = {
  breadcrumb = "» ", -- symbol used in the command line area that shows your active key combo
  separator = icons.ui.ChevronRight, -- symbol used between a key and it's label
  group = "+ ", -- symbol prepended to a group
}
icons.kind = {
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
icons.cmp_kind = vim.tbl_extend("keep", icons.kind, {
  Color = " ",
  Folder = icons.documents.Folder .. " ",
  Keyword = " ",
  Reference = " ",
  Snippet = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
})
icons.cmp_source = {
  buffer = "﬘ ",
  luasnip = "  ",
  nvim_lsp = " ",
  nvim_lua = " ",
  path = icons.documents.Folder .. " ",
  cmp_tabnine = icons.ui.Robot .. " ",
}
icons.git_states = {
  unstaged = icons.git.Mod,
  staged = " ",
  unmerged = "ﱵ ",
  renamed = icons.git.Rename,
  untracked = "ﱡ ",
  deleted = icons.git.Remove,
  ignored = icons.git.Ignore,
}
icons.lualine = {
  modified = icons.ui.Circle, -- Text to show when the file is modified.
  newfile = icons.documents.NewFile, -- Text to show for new created file before first writting
  readonly = icons.ui.lock, -- Text to show when the file is non-modifiable or readonly.
  unnamed = icons.documents.File, -- Text to show for unnamed buffers.
}
icons.mason = {
  package_installed = icons.ui.Check,
  package_pending = icons.ui.Sync,
  package_uninstalled = icons.ui.Close,
}

---Provides the editors icons
local M = {}

---Ensures that the icons of given parts exists
---@param ... string List of parts the actual icon path
---@return string|table|nil The icon symbol or nil if not found
function M.get_icon(...)
  local icon = icons
  local parts = { ... }
  local function get_icon(name)
    return icon[name]
  end

  for _, name in ipairs(parts) do
    local found_icon, _icon = pcall(get_icon, name)
    if not found_icon then
      vim.pretty_print("[cange.utils.icons] icon for " .. vim.inspect(parts) .. " not found")
      return nil
    end

    icon = _icon
  end

  -- vim.pretty_print("icon", icon)
  return icon
end

return M
