local lsp = _G.bulk_loader('mason-lspconfig', {
  { 'mason-lspconfig', 'mason_lspconfig' },
  { 'cange.lsp.providers', 'providers' },
})

lsp.mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = lsp.providers,
  -- A list of provide to automatically install if they're not already
  -- installed. Example: { "rust_analyzer@nightly", "sumneko_lua" } This
  -- setting has no relation with the `automatic_installation` setting.
  automatic_installation = true,
})
