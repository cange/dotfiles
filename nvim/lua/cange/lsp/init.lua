local found, _ = pcall(require, 'lspconfig')
if not found then
  return
end

require('cange.lsp.mason') -- setup order: first
require('cange.lsp.mason-lspconfig') -- setup order: second
require('cange.lsp.lspconfig') -- setup order: third
require('cange.lsp.null-ls')

local icons = require('cange.icons')
local signs = {
  { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
  { name = 'DiagnosticSignWarn',  text = icons.diagnostics.Warning },
  { name = 'DiagnosticSignHint',  text = icons.diagnostics.Hint },
  { name = 'DiagnosticSignInfo',  text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end
