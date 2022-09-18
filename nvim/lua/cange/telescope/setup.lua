local found, telescope = pcall(require, 'telescope')
if not found then
  return
end

local actions = require('telescope.actions')
local keymap_opts = { noremap = true, silent = true }
local picker_opts = {
  theme = 'dropdown',
  previewer = false,
}
telescope.setup({
  defaults = {
    path_display = {
      'shorten',
      'absolute',
    },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    find_files = picker_opts,
    grep_string = picker_opts,
  },
})
