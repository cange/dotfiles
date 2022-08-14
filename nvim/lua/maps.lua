local keymap = vim.keymap

-- Do not yank x
keymap.set('n', 'x', '"_x')

-- sort line
keymap.set('v', '<F5>', ':sort<CR>gv=gv')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab "ctrl+w + t"
keymap.set('n', '<C-w>t', ':tabedit<Return>', { silent = true })

-- Move window "w+<direction>"
keymap.set('', 'w<down>', '<C-w>j')
keymap.set('', 'w<left>', '<C-w>h')
keymap.set('', 'w<right>', '<C-w>l')
keymap.set('', 'w<up>', '<C-w>k')
keymap.set('', 'wh', '<C-w>h')
keymap.set('', 'wj', '<C-w>j')
keymap.set('', 'wk', '<C-w>k')
keymap.set('', 'wl', '<C-w>l')
keymap.set('n', '<Space>', '<C-w>w')

-- Moving lines
keymap.set('i', '<C-down>', '<Esc>:m .+1<CR>==gi')
keymap.set('i', '<C-up>', '<Esc>:m .-2<CR>==gi')
keymap.set('n', '<C-down>', ':m .+1<CR>==')
keymap.set('n', '<C-up>', ':m .-2<CR>==')
keymap.set('v', '<C-down>', ':m ">+1<CR>gv=gv')
keymap.set('v', '<C-up>', ':m "<-2<CR>gv=gv')

-- switch between the last recent open two files
keymap.set('n', '<leader><leader>', '<C-^>')
