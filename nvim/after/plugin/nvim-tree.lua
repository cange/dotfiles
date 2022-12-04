-- local ns = "[plugin/nvim-tree]"
local found, tree = pcall(require, "nvim-tree")
if not found then
  return
end
local bookmark_nav = require("nvim-tree.api").marks.navigate
local keymap = Cange.keymap
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap("n", "<leader>.", ":NvimTreeFindFile<CR>")

keymap("n", "<leader>mn", bookmark_nav.next)
keymap("n", "<leader>mp", bookmark_nav.prev)
keymap("n", "<leader>ms", bookmark_nav.select)

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
    prefix = Cange.get_icon("ui", "Search") .. "  ",
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
        default = Cange.get_icon("documents", "File", { trim = true }),
        bookmark = Cange.get_icon("ui", "Bookmark", { trim = true }),
        symlink = Cange.get_icon("documents", "SymlinkFile", { trim = true }),
        folder = {
          arrow_closed = Cange.get_icon("ui", "ChevronRight"),
          arrow_open = Cange.get_icon("ui", "ChevronDown"),
          default = Cange.get_icon("documents", "Folder"),
          empty = Cange.get_icon("documents", "EmptyFolder"),
          empty_open = Cange.get_icon("documents", "EmptyOpenFolder"),
          open = Cange.get_icon("documents", "OpenFolder"),
          symlink = Cange.get_icon("documents", "SymlinkFolder"),
          symlink_open = Cange.get_icon("documents", "SymlinkFolder"),
        },
        git = Cange.get_icon("git_states"),
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      error = Cange.get_icon("diagnostics", "Error"),
      warning = Cange.get_icon("diagnostics", "Warning"),
      hint = Cange.get_icon("diagnostics", "Hint"),
      info = Cange.get_icon("diagnostics", "Information"),
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
