local lsp = Cange.bulk_loader('lsp', {
  { 'lspconfig', 'lspconfig' },
  { 'cmp_nvim_lsp', 'cmp_lsp' },
  { 'cange.lsp.custom', 'custom' },
  { 'cange.lsp.providers', 'providers' },
})

local function setup_server(provider, lspconfig)
  local found_settings, settings = pcall(require, 'cange.lsp.provider_settings.' .. provider)
  local default_settings = {
    on_attach = lsp.custom.on_attach,
    capabilities = lsp.custom.capabilities(),
    name = provider, -- Name in log messageis
    -- flags = {
    --   debounce_text_changes = 250, -- server debounce didChange in milliseconds
    -- }
  }
  if found_settings then
    settings = vim.tbl_deep_extend('force', settings, default_settings)
  else
    settings = default_settings
  end
  -- vim.pretty_print(provider, 'config', vim.tbl_keys(settings))

  lspconfig[provider].setup(settings)
end

for _, provider in pairs(lsp.providers.language_servers) do
  setup_server(provider, lsp.lspconfig)
end
