local ok, _ = pcall(require, 'lspconfig')
if not ok then return end

require('cange.lsp.mason') -- setup order: first
require('cange.lsp.mason-lspconfig') -- setup order: second
require('cange.lsp.lspconfig') -- setup order: third
require('cange.lsp.null-ls')
require('cange.lsp.handlers').setup()
