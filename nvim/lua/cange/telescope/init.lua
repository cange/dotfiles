local modules = BULK_LOADER('telescope', {
  { 'telescope', 'telescope' },
  'cange.telescope.setup',
  'cange.telescope.custom',
})
local telescope = modules.telescope

telescope.load_extension('textcase')
telescope.load_extension('session-lens')
telescope.load_extension('notify')
telescope.load_extension('projects')
