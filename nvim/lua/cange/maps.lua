local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Do not yank x
map('n', 'x', '"_x', opts)

-- sort line
map('v', '<F5>', ':sort<CR>gv=gv', opts)

-- Increment/decrement
map('n', '+', '<C-a>', opts)
map('n', '-', '<C-x>', opts)

-- map('n', 'dw', 'vb"_d',opts) -- Delete a word backwards
map('v', 'p', '"_dP', opts) -- Keep clipboard content instead of overriding it

-- Select all
map('n', '<C-a>', 'gg<S-v>G', opts)

-- New tab "ctrl+w + t"
map('n', '<C-w>t', ':tabedit<Return>', opts)

-- Move window "w+<direction>"
map('', 'w<down>', '<C-w>j', opts)
map('', 'w<left>', '<C-w>h', opts)
map('', 'w<right>', '<C-w>l', opts)
map('', 'w<up>', '<C-w>k', opts)
map('', 'wh', '<C-w>h', opts)
map('', 'wj', '<C-w>j', opts)
map('', 'wk', '<C-w>k', opts)
map('', 'wl', '<C-w>l', opts)
map('n', '<Space>', '<C-w>w', opts)

-- Resize widow swith arrows
map('n', '<C-down>', ':resize +4<CR>', opts)
map('n', '<C-left>', ':vertical resize -4<CR>', opts)
map('n', '<C-right>', ':vertical resize +4<CR>', opts)
map('n', '<C-up>', ':resize -4<CR>', opts)

-- Moving lines up and down
map('i', '<A-down>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-up>', '<Esc>:m .-2<CR>==gi', opts)
map('n', '<A-down>', ':m .+1<CR>==', opts)
map('n', '<A-up>', ':m .-2<CR>==', opts)
map('v', '<A-down>', ':m ">+1<CR>gv=gv', opts)
map('v', '<A-up>', ':m "<-2<CR>gv=gv', opts)

-- switch between the last recent open two files
map('n', '<leader><leader>', '<C-^>', opts)

-- Keep selection marked when indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('v', '<Tab>', '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)
