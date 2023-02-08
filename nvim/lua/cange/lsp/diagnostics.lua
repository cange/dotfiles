---@class DiagnosticSignSeverity
---@field name string
---@field text string

---@type table<DiagnosticSignSeverity>
local signs = {}

for name, icon in pairs(Cange.get_icon("diagnostics")) do
  local hl_name = "DiagnosticSign" .. name

  vim.pretty_print(hl_name, icon)
  signs = vim.tbl_extend("force", signs, { name = hl_name, text = icon })
  vim.fn.sign_define(hl_name, { texthl = hl_name, text = icon, numhl = "" })
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
