local found_textcase, textcase = pcall(require, 'textcase')
if not found_textcase then
  return
end

textcase.setup({})

vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })
