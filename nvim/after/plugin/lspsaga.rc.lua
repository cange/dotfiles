local ok, saga = pcall(require, 'lspsaga')
if not ok then return end

saga.init_lsp_saga {
  server_filetype_map = {
    typescript = 'typescript'
  }
}

-- https://github.com/glepnir/lspsaga.nvim#configuration
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then your can
-- use <C-t> to jump back
map('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)

-- Code action
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
map('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)

-- Diagnsotic jump
map('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
map('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

-- Only jump to error
map('n', '<C-J>', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
map('n', '<C-K>', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

map('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)

map('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
map('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
map('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
