local ns = 'telescope.init'
local found_telescope, telescope = pcall(require, 'telescope')
if not found_telescope then
  print('[' .. ns .. '] "telescope" not found')
  return
end

Cange.bulk_loader(ns, { 'cange.telescope.setup', 'cange.telescope.custom' })

telescope.load_extension('textcase')
telescope.load_extension('session-lens')
telescope.load_extension('notify')
telescope.load_extension('projects')
