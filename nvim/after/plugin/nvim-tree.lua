local ns = "[plugin/nvim-tree]"
local found, tree = pcall(require, "nvim-tree")
if not found then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
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

api.events.subscribe(Event.TreeClose, function()
  keymap("n", toggle_help_key, "<Nop>")
end)

local config = require("nvim-tree.config").nvim_tree_callback
tree.setup({
  live_filter = {
    prefix = utils.get_icon("ui", "Search") .. "  ",
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
        folder_arrow = false,
      },
      git_placement = "after",
      glyphs = {
        default = utils.get_icon("documents", "File"),
        bookmark = utils.get_icon("ui", "Bookmark"),
        symlink = utils.get_icon("documents", "SymlinkFile"),
        folder = {
          arrow_closed = utils.get_icon("ui", "ChevronRight"),
          arrow_open = utils.get_icon("ui", "ChevronDown"),
          default = utils.get_icon("documents", "Folder"),
          empty = utils.get_icon("documents", "EmptyFolder"),
          empty_open = utils.get_icon("documents", "EmptyOpenFolder"),
          open = utils.get_icon("documents", "OpenFolder"),
          symlink = utils.get_icon("documents", "SymlinkFolder"),
          symlink_open = utils.get_icon("documents", "SymlinkFolder"),
        },
        git = utils.get_icon("git_states"),
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      error = utils.get_icon("diagnostics", "Error"),
      warning = utils.get_icon("diagnostics", "Warning"),
      hint = utils.get_icon("diagnostics", "Hint"),
      info = utils.get_icon("diagnostics", "Information"),
    },
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
