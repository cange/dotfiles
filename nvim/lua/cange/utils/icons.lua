---@class cange.utils.Icons
---@field cmp_kind table Completion kinds
---@field cmp_source table
---@field diagnostics table
---@field git table
---@field git_states table
---@field kind table Language symbols
---@field lualine table
---@field mason table Mason LSP local anguage server plugin
---@field ui table Generic icons for general purposes
---@field which_key table
---@filed documents table

local icons = {}
-- Icons works best with "FiraCode Nerd Font"
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

icons.ui = {
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
  Add = " ", -- nf-oct-diff_added,
  Mod = " ", -- nf-oct-diff_modified
  Remove = " ", -- nf-oct-diff_removed
  Ignore = " ", -- nf-oct-diff_ignored
  Rename = " ", -- nf-oct-diff_renamed
  Diff = " ", -- nf-oct-diff
  Branch = " ", --nf-oct-git_branch
  Octoface = " ", -- nf-oct-octoface
}
icons.diagnostics = {
  Error = " ", -- nf-mdi-close_circle
  Warning = " ", -- nf-mdi-information_outline
  Information = " ", -- nf-mdi-information
  Question = "ﬤ ", -- nf-mdi-help_circle_outline
  Hint = " ", -- nf-mdi-lightbulb
}
icons.which_key = {
  breadcrumb = " ", -- nf-oct-arrow_right
  separator = icons.ui.ChevronRight, -- symbol used between a key and it's label
  group = " ", -- nf-oct-plus_small
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
  luasnip = " ", -- nf-fa-cut
  nvim_lsp = " ",
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
---@param group_id string Identifier of the icon group
---@param ... string List of parts the actual icon path
---@return string|nil The icon symbol or nil if not found
function M.get(group_id, ...)
  local icon = icons
  local parts = { ... }
  local function get_icon(name)
    local result = icon[name]
    if not result then
      vim.pretty_print("[cange.utils.icons] icon for " .. name .. " not found")
      return nil
    end
    return result
  end

  icon = get_icon(group_id)
  if #parts > 0 then
    for _, name in ipairs(parts) do
      icon = get_icon(name)
    end
  end

  -- vim.pretty_print("icon", icon)
  return icon
end

return M
