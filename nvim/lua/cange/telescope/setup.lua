local ns = 'cange.telescope.setup'
local found_telescope, telescope = pcall(require, 'telescope')
if not found_telescope then
  print('[' .. ns .. '] "telescope" not found')
  return
end
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
local actions = require('telescope.actions')
-- config
local default_opts = {
  previewer = false,
  theme = 'dropdown',
}
local lsp_opts = {
  initial_mode = 'normal',
  previewer = false,
  theme = 'dropdown',
}
-- setup
telescope.setup({
  defaults = {
    path_display = {
      'smart', -- shows only the difference between the displayed paths
      'absolute',
    },
    prompt_prefix = ' ' .. icons.ui.Search .. ' ',
    selection_caret = ' ' .. icons.ui.ChevronRight .. ' ',
    entry_prefix = '   ',
    layout_config = {
      horizontal = {
        preview_width = 80,
        prompt_position = 'top',
      },
    },
    scroll_strategy = 'cycle',
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<C-s>'] = actions.cycle_history_next,
        ['<C-a>'] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = default_opts,
    colorscheme = default_opts,
    find_files = default_opts,
    quickfix = default_opts,
    live_grep = { theme = default_opts.theme },
    grep_string = default_opts,
    lsp_references = lsp_opts,
    lsp_declarations = lsp_opts,
    lsp_definitions = lsp_opts,
  },
})
