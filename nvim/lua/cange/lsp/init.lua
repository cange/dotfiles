_G.bulk_loader('lsp', {
  { 'cange.lsp.mason', 'mason' }, --[[ 1 ]]
  { 'cange.lsp.mason-lspconfig', 'mason_lspconfig' }, --[[ 2 ]]
  { 'cange.lsp.lspconfig', 'lspconfig' }, --[[ 3 ]]
  { 'cange.lsp.null-ls', 'null_ls' }, --[[ 4 ]]
})
local utils = _G.bulk_loader('lsp', { { 'cange.icons', 'icons' } })
local signs = {
  { name = 'DiagnosticSignError', text = utils.icons.diagnostics.Error },
  { name = 'DiagnosticSignWarn', text = utils.icons.diagnostics.Warning },
  { name = 'DiagnosticSignHint', text = utils.icons.diagnostics.Hint },
  { name = 'DiagnosticSignInfo', text = utils.icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end
