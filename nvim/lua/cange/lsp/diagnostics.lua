-- local ns = "[cange.lsp.diagnostics]"
-- config
local signs = {
  { name = "DiagnosticSignError", text = Cange.get_icon("diagnostics", "Error") },
  { name = "DiagnosticSignWarn", text = Cange.get_icon("diagnostics", "Warning") },
  { name = "DiagnosticSignHint", text = Cange.get_icon("diagnostics", "Hint") },
  { name = "DiagnosticSignInfo", text = Cange.get_icon("diagnostics", "Information") },
}

for _, s in ipairs(signs) do
  vim.fn.sign_define(s.name, { texthl = s.name, text = s.text, numhl = "" })
end

vim.diagnostic.config({
  float = {
    source = "if_many", -- Or "always"
  },
  signs = {
    active = signs,
  },
  virtual_text = Cange.get_config("lsp.diagnostic_virtual_text") or false,
})
