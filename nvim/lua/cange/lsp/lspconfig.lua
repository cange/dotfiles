local ns =  'cange.lsp.lspconfig'
local found_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not found_lspconfig then
  print('[' .. ns .. '] "lspconfig" not found')
  return
end
local found_custom, custom = pcall(require, 'cange.lsp.custom')
if not found_custom then
  print('[' .. ns .. '] "cange.utils.custom" not found')
  return
end
local found_providers, providers = pcall(require, 'cange.lsp.providers')
if not found_providers then
  print('[' .. ns .. '] "cange.utils.providers" not found')
  return
end
-- config
local function setup_server(provider, p_lspconfig)
  local found_settings, settings = pcall(require, 'cange.lsp.provider_settings.' .. provider)
  local default_settings = {
    on_attach = custom.on_attach,
    capabilities = custom.capabilities(),
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

  p_lspconfig[provider].setup(settings)
end

for _, provider in pairs(providers.language_servers) do
  setup_server(provider, lspconfig)
end
