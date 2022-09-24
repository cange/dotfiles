local found_keymaps, k = pcall(require, 'cange.utils.keymaps')
if not found_keymaps then
  print('[cange.keybindings.common] "cange.utils.keymaps" not found')
  return
end

--[[
  FIRST: Set leader key
  Leader needs to be defined before any other keymaps definintions
]]
vim.g.mapleader = ' '

-- Do not yank x
k.nmap('x', '"_x')

-- sort line
k.vmap('<F5>', ':sort<CR>gv=gv')

-- Increment/decrement
k.nmap('+', '<C-a>')
k.nmap('-', '<C-x>')

k.vmap('p', '"_dP') -- Keep clipboard content instead of overriding it

-- greatest remap ever
k.xmap('<leader>p', '"_dP')
--
-- -- next greatest remap ever : asbjornHaland
k.nvmap('<leader>y', '"+y')
k.nvmap('<leader>d', '"_d')
k.nmap('<leader>Y', '"+Y', { noremap = false })

-- Select all content
k.nmap('<C-a>', 'gg<S-v>G')

-- New tab "ctrl+w + t"
k.nmap('<C-w>t', ':tabedit<CR>')

-- Move window "w+<direction>"
k.map('w<down>', '<C-w>j')
k.map('w<left>', '<C-w>h')
k.map('w<right>', '<C-w>l')
k.map('w<up>', '<C-w>k')
k.map('wh', '<C-w>h')
k.map('wj', '<C-w>j')
k.map('wk', '<C-w>k')
k.map('wl', '<C-w>l')

-- Resize widow swith arrows
k.nmap('<S-C-down>', ':resize +4<CR>')
k.nmap('<S-C-left>', ':vertical resize -4<CR>')
k.nmap('<S-C-right>', ':vertical resize +4<CR>')
k.nmap('<S-C-up>', ':resize -4<CR>')

-- Moving lines up and down
k.imap('<A-down>', '<Esc>:move .+1<CR>==gi')
k.imap('<A-up>', '<Esc>:move .-2<CR>==gi')
k.nmap('<A-down>', ':move .+1<CR>==')
k.nmap('<A-up>', ':move .-2<CR>==')
k.vmap('<A-down>', ":move '>+1<CR>gv=gv")
k.vmap('<A-up>', ":move '<-2<CR>gv=gv")

-- switch between the last recent open two files
k.nmap('<leader><leader>', '<C-^>')

-- Keep selection marked when indenting
k.vmap('<', '<gv')
k.vmap('>', '>gv')
k.vmap('<Tab>', '>gv')
k.vmap('<S-Tab>', '<gv')

-- Reload current file
k.nmap('<C-x>', ':write<CR>:source %<CR>:lua vim.notify("File saved and executed")<CR>')
