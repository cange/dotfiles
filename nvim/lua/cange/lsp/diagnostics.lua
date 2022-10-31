local ns = "cange.lsp.diagnostics"
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found)')
  return
end
-- config
local signs = {
  { name = "DiagnosticSignError", text = utils.get_icon("diagnostics", "Error") },
  { name = "DiagnosticSignWarn", text = utils.get_icon("diagnostics", "Warning") },
  { name = "DiagnosticSignHint", text = utils.get_icon("diagnostics", "Hint") },
  { name = "DiagnosticSignInfo", text = utils.get_icon("diagnostics", "Information") },
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
  virtual_text = utils.get_config("lsp.diagnostic_virtual_text") or false,
})
