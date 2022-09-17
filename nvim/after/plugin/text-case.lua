local found_textcase, textcase = pcall(require, 'textcase')
if not found_textcase then
  return
end

textcase.setup({})

local found_telescope, telescope = pcall(require, 'telescope')
if not found_telescope then
  vim.notify('[textcase] "telescope" not found')
  return
end

telescope.load_extension('textcase')

vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })
