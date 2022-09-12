local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = ' '

-- Do not yank x
keymap('n', 'x', '"_x', opts)

-- sort line
keymap('v', '<F5>', ':sort<CR>gv=gv', opts)

-- Increment/decrement
keymap('n', '+', '<C-a>', opts)
keymap('n', '-', '<C-x>', opts)

keymap('v', 'p', '"_dP', opts) -- Keep clipboard content instead of overriding it

-- greatest remap ever
-- keymap('x', '<leader>p', '\"_dP', opts)
--
-- -- next greatest remap ever : asbjornHaland
-- keymap({ 'n', 'v' }, '<leader>y', '"+y', opts)
-- keymap({ 'n', 'v' }, '<leader>d', '"_d', opts)
-- keymap('n', '<leader>Y', '"+Y', { noremap = false })

-- Select all content
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- New tab "ctrl+w + t"
keymap('n', '<C-w>t', ':tabedit<CR>', opts)

-- Move window "w+<direction>"
keymap('', 'w<down>', '<C-w>j', opts)
keymap('', 'w<left>', '<C-w>h', opts)
keymap('', 'w<right>', '<C-w>l', opts)
keymap('', 'w<up>', '<C-w>k', opts)
keymap('', 'wh', '<C-w>h', opts)
keymap('', 'wj', '<C-w>j', opts)
keymap('', 'wk', '<C-w>k', opts)
keymap('', 'wl', '<C-w>l', opts)

-- Resize widow swith arrows
keymap('n', '<C-down>', ':resize +4<CR>', opts)
keymap('n', '<C-left>', ':vertical resize -4<CR>', opts)
keymap('n', '<C-right>', ':vertical resize +4<CR>', opts)
keymap('n', '<C-up>', ':resize -4<CR>', opts)

-- Moving lines up and down
keymap('i', '<A-down>', '<Esc>:move .+1<CR>==gi', opts)
keymap('i', '<A-up>', '<Esc>:move .-2<CR>==gi', opts)
keymap('n', '<A-down>', ':move .+1<CR>==', opts)
keymap('n', '<A-up>', ':move .-2<CR>==', opts)
keymap('v', '<A-down>', ":move '>+1<CR>gv=gv", opts)
keymap('v', '<A-up>', ":move '<-2<CR>gv=gv", opts)

-- switch between the last recent open two files
keymap('n', '<leader><leader>', '<C-^>', opts)

-- Keep selection marked when indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('v', '<Tab>', '>gv', opts)
keymap('v', '<S-Tab>', '<gv', opts)

-- Reload current file
keymap('n', '<leader>r', ':source %<CR>:lua vim.notify("Reload current file")<CR>', opts)

-- Formatting
keymap({ 'n', 'v' }, '=', ':lua vim.lsp.buf.formatting_seq_sync()<CR>', opts)

-- Plugins/worklfows
local found_settings, editor_settings = pcall(require, 'cange.settings.editor')
if found_settings then
  editor_settings.keymaps.setup()
else
  vim.notify('keymaps: "cange.settings.editor" could not be found')
end
