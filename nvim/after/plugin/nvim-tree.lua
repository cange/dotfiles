local found, tree = pcall(require, 'nvim-tree')
if not found then
  return
end
local k = Cange.load('toggleterm', 'cange.utils.keymaps')

k.nmap('<leader>e', ':NvimTreeToggle<CR>')
k.nmap('<leader>.', ':NvimTreeFindFile<CR>')
local api = require('nvim-tree.api')
local Event = api.events.Event
local toggle_help_key = '<leader>eh'

-- enable help toggle when tree open
api.events.subscribe(Event.TreeOpen, function()
  k.nmap(toggle_help_key, function()
    api.tree.toggle_help()
  end)
end)

k.nmap(toggle_help_key, '<Nop>')
api.events.subscribe(Event.TreeClose, function() end)

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
