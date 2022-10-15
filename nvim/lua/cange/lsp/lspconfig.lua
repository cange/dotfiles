local ns = "cange.lsp.lspconfig"
local found_lspconfig, lspconfig = pcall(require, "lspconfig")
if not found_lspconfig then
  print("[" .. ns .. '] "lspconfig" not found')
  return
end
local found_custom, custom = pcall(require, "cange.lsp.custom")
if not found_custom then
  print("[" .. ns .. '] "cange.utils.custom" not found')
  return
end
local found_servers, servers = pcall(require, "cange.lsp.servers")
if not found_servers then
  print("[" .. ns .. '] "cange.utils.servers" not found')
  return
end

local function setup_server(server, p_lspconfig)
  local found_config, config = pcall(require, "cange.lsp.server_configurations." .. server)
  local default_config = {
    on_attach = custom.on_attach,
    capabilities = custom.capabilities(),
    name = server, -- for log messages
  }
  if found_config then
    config = vim.tbl_deep_extend("force", config, default_config)
  else
    config = default_config
  end
  -- vim.pretty_print(provider, 'config', vim.tbl_keys(config))

  p_lspconfig[server].setup(config)
end

for _, server in pairs(servers) do
  setup_server(server, lspconfig)
end
