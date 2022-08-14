local loaded, tree = pcall(require, 'nvim-tree')
if (not loaded) then return end

tree.setup()

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>|', ':NvimTreeFindFile<CR>')
