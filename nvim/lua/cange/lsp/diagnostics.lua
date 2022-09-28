local ns = 'cange.lsp.diagnostics'
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
-- config
local signs = {
  { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
  { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
  { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
  { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
}

for _, s in ipairs(signs) do
  vim.fn.sign_define(s.name, { texthl = s.name, text = s.text, numhl = '' })
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
