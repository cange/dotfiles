local telescope = BULK_LOADER('telescope', {
  { 'telescope', 'telescope' },
  { 'telescope.actions', 'actions' },
})
local utils = BULK_LOADER('mappings', {
  { 'cange.icons', 'icons' },
})

local default_opts = {
  theme = 'dropdown',
  previewer = false,
}
local lsp_opts = {
  initial_mode = 'normal',
  previewer = false,
  theme = 'dropdown',
}
telescope.telescope.setup({
  defaults = {
    path_display = {
      'shorten',
      'absolute',
    },
    prompt_prefix = ' ' .. utils.icons.ui.Search .. ' ',
    selection_caret = ' ' .. utils.icons.ui.ChevronRight .. ' ',
    entry_prefix = '   ',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<C-n>'] = telescope.actions.cycle_history_next,
        ['<C-p>'] = telescope.actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = default_opts,
    colorscheme = default_opts,
    find_files = default_opts,
    live_grep = { theme = default_opts.theme },
    grep_string = default_opts,
    lsp_references = lsp_opts,
    lsp_declarations = lsp_opts,
    lsp_definitions = lsp_opts,
  },
})
