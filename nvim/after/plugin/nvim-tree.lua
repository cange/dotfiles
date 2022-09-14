local found, tree = pcall(require, 'nvim-tree')
if not found then
  return
end
local keymap_opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', keymap_opts)
keymap('n', '<leader>.', ':NvimTreeFindFile<CR>', keymap_opts)
local api = require('nvim-tree.api')
local Event = api.events.Event
local toggle_help_key = '<leader>eh'

-- enable help toggle when tree open
api.events.subscribe(Event.TreeOpen, function()
  keymap('n', toggle_help_key, function()
    api.tree.toggle_help()
  end, keymap_opts)
end)

-- disable help toggle when tree closed
api.events.subscribe(Event.TreeClose, function()
  keymap('n', toggle_help_key, '<Nop>', keymap_opts)
end)

local config = require('nvim-tree.config').nvim_tree_callback
local icons = require('cange.icons')

tree.setup({
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
      glyphs = {
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
        { key = 'v', cb = config('vsplit') },
        { key = 'h', cb = config('split') },
      },
    },
  },
})
