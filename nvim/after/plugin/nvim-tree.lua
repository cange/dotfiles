local ns = "nvim-tree"
local found, tree = pcall(require, "nvim-tree")
if not found then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
local keymap = utils.keymap
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap("n", "<leader>.", ":NvimTreeFindFile<CR>")

local api = require("nvim-tree.api")
local Event = api.events.Event
local toggle_help_key = "<leader>eh"

-- enable help toggle when tree open
api.events.subscribe(Event.TreeOpen, function()
  keymap("n", toggle_help_key, function()
    api.tree.toggle_help()
  end)
end)

keymap("n", toggle_help_key, "<Nop>")
api.events.subscribe(Event.TreeClose, function() end)

local config = require("nvim-tree.config").nvim_tree_callback
local icons = utils.icons
tree.setup({
  live_filter = {
    prefix = icons.ui.Search .. "  ",
  },
  -- project plugin related
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- common
  renderer = {
    icons = {
      show = {
        folder = false,
      },
      git_placement = "after",
      glyphs = {
        default = icons.documents.File,
        bookmark = icons.ui.Bookmark,
        symlink = icons.documents.SymlinkFile,
        folder = {
          arrow_closed = icons.ui.ChevronRight,
          arrow_open = icons.ui.ChevronDown,
          default = icons.documents.Folder,
          empty = icons.documents.EmptyFolder,
          empty_open = icons.documents.EmptyOpenFolder,
          open = icons.documents.OpenFolder,
          symlink = icons.documents.SymlinkFolder,
          symlink_open = icons.documents.SymlinkFolder,
        },
        git = icons.git_states,
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    mappings = {
      list = {
        { key = "v", cb = config("vsplit") },
        { key = "h", cb = config("split") },
      },
    },
  },
})
