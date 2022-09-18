local telescope = BULK_LOADER('telescope', {
  { 'telescope', 'telescope' },
  { 'telescope.actions', 'actions' },
})

local picker_opts = {
  theme = 'dropdown',
  previewer = false,
}
telescope.telescope.setup({
  defaults = {
    path_display = {
      'shorten',
      'absolute',
    },
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
    find_files = picker_opts,
    grep_string = picker_opts,
  },
})
