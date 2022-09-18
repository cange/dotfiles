local modules = BULK_LOADER('lsp', {
  { 'cange.icons', 'icons' },
  -- { 'cange.lsp.mason', 'mason' }, --[[ 1 ]]
  -- { 'cange.lsp.mason-lspconfig', 'mason_lspconfig' }, --[[ 2 ]]
  { 'cange.lsp.lspconfig', 'lspconfig' }, --[[ 3 ]]
  -- { 'cange.lsp.null-ls', 'null_ls' }, --[[ 4 ]]
})


local signs = {
  { name = 'DiagnosticSignError', text = modules.icons.diagnostics.Error },
  { name = 'DiagnosticSignWarn', text = modules.icons.diagnostics.Warning },
  { name = 'DiagnosticSignHint', text = modules.icons.diagnostics.Hint },
  { name = 'DiagnosticSignInfo', text = modules.icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end
