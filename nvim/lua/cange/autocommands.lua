-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
local opts = {}

augroup('cange_remove_whitespace_on_save', opts)
autocmd('BufWritePre', {
  pattern = '*',
  command = ':%s/\\s\\+$//e'
})

-- augroup('cange_eslint_autofix_on_save', opts)
-- -- EslintFixAll: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt#eslint
-- autocmd('BufWritePre', {
--   pattern = '*.tsx,*.ts,*.jsx,*.js,*.vue',
--   command = 'EslintFixAll'
-- })
