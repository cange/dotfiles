local map = vim.keymap.set

-- Do not yank x
map('n', 'x', '"_x')

-- sort line
map('v', '<F5>', ':sort<CR>gv=gv')

-- Increment/decrement
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Delete a word backwards
-- map('n', 'dw', 'vb"_d')

-- Select all
map('n', '<C-a>', 'gg<S-v>G')

-- New tab "ctrl+w + t"
map('n', '<C-w>t', ':tabedit<Return>', { silent = true })

-- Move window "w+<direction>"
map('', 'w<down>', '<C-w>j')
map('', 'w<left>', '<C-w>h')
map('', 'w<right>', '<C-w>l')
map('', 'w<up>', '<C-w>k')
map('', 'wh', '<C-w>h')
map('', 'wj', '<C-w>j')
map('', 'wk', '<C-w>k')
map('', 'wl', '<C-w>l')
map('n', '<Space>', '<C-w>w')

-- Moving lines
map('i', '<C-down>', '<Esc>:m .+1<CR>==gi')
map('i', '<C-up>', '<Esc>:m .-2<CR>==gi')
map('n', '<C-down>', ':m .+1<CR>==')
map('n', '<C-up>', ':m .-2<CR>==')
map('v', '<C-down>', ':m ">+1<CR>gv=gv')
map('v', '<C-up>', ':m "<-2<CR>gv=gv')

-- switch between the last recent open two files
map('n', '<leader><leader>', '<C-^>')
