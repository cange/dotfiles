local keymap = Cange.keymap

--[[
  FIRST: Set leader key
  Leader needs to be defined before any other keymaps definintions
]]
vim.g.mapleader = ' '

-- sort line
keymap('v', '<F5>', ':sort<CR>gv=gv')

keymap('v', 'p', '"_dP') -- Keep clipboard content instead of overriding it

-- greatest remap ever
keymap('x', '<leader>p', '"_dP')
--
-- -- next greatest remap ever : asbjornHaland
keymap({ 'n', 'v' }, '<leader>y', '"+y')
keymap({ 'n', 'v' }, '<leader>d', '"_d')
keymap('n', '<leader>Y', '"+Y', { noremap = false })
--
-- Select all content
keymap('n', '<C-a>', 'gg<S-v>G')
--
-- New tab "ctrl+w + t"
keymap('n', '<C-w>t', ':tabedit<CR>')

-- Move window "w+<direction>"
keymap('', 'w<down>', '<C-w>j')
keymap('', 'w<left>', '<C-w>h')
keymap('', 'w<right>', '<C-w>l')
keymap('', 'w<up>', '<C-w>k')
keymap('', 'wh', '<C-w>h')
keymap('', 'wj', '<C-w>j')
keymap('', 'wk', '<C-w>k')
keymap('', 'wl', '<C-w>l')

-- Resize widow swith arrows
keymap('n', '<S-C-down>', ':resize +4<CR>')
keymap('n', '<S-C-left>', ':vertical resize -4<CR>')
keymap('n', '<S-C-right>', ':vertical resize +4<CR>')
keymap('n', '<S-C-up>', ':resize -4<CR>')

-- Moving lines up and down
keymap('i', '<A-down>', '<Esc>:move .+1<CR>==gi')
keymap('i', '<A-up>', '<Esc>:move .-2<CR>==gi')
keymap('n', '<A-down>', ':move .+1<CR>==')
keymap('n', '<A-up>', ':move .-2<CR>==')
keymap('v', '<A-down>', ":move '>+1<CR>gv=gv")
keymap('v', '<A-up>', ":move '<-2<CR>gv=gv")

-- switch between the last recent open two files
keymap('n', '<leader><leader>', '<C-^>')

-- Keep selection marked when indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')
keymap('v', '<Tab>', '>gv')
keymap('v', '<S-Tab>', '<gv')

-- Reload current file
keymap('n', '<C-x>', ':write<CR>:source %<CR>:lua vim.notify("File saved and executed")<CR>')
