local found, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not found then return end

local found_settings, settings = pcall(require, 'cange.settings')
if not found_settings then
  vim.notify 'mason-lspconfig: "cange.settings" could not be found'
  return
end

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = settings.lsp.providers.lsp,
  -- A list of provide to automatically install if they're not already
  -- installed. Example: { "rust_analyzer@nightly", "sumneko_lua" } This
  -- setting has no relation with the `automatic_installation` setting.
  automatic_installation = true,
})
