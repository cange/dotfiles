local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then return end

local providers_ok, providers = pcall(require, 'cange.lsp.providers')
if not providers_ok then
  vim.notify 'mason-lspconfig: LSP provider could not be found'
  return
end

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = providers.lsp,
  -- A list of provide to automatically install if they're not already
  -- installed. Example: { "rust_analyzer@nightly", "sumneko_lua" } This
  -- setting has no relation with the `automatic_installation` setting.
  automatic_installation = true,
})
