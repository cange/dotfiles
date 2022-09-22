local utils = _G.bulk_loader('lsp', { { 'cange.icons', 'icons' } })
local icons = utils.icons
local signs = {
  { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
  { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
  { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
  { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  float = {
    source = 'if_many', -- Or "always"
  },
  signs = {
    active = signs,
  },
  virtual_text = false, -- disable inline text
})

local handlers_opts = { border = 'rounded' }
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, handlers_opts)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, handlers_opts)
