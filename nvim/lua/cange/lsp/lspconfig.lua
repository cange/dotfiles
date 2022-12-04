local ns = "[cange.lsp.lspconfig]"
local found_lspconfig, lspconfig = pcall(require, "lspconfig")
if not found_lspconfig then
  print(ns, '"lspconfig" not found')
  return
end

-- Enable TypeScript/JS basic LSP feature via plugin
-- https://github.com/jose-elias-alvarez/typescript.nvim#setup
local found_typescript, typescript = pcall(require, "typescript")
if not found_typescript then
  print(ns, ' "typescript" not found')
  return
end

local found_custom, custom = pcall(require, "cange.lsp.custom")
if not found_custom then
  print(ns, '"cange.lsp.custom" not found')
  return
end

local function setup_server(server, config)
  local found_config, server_config = pcall(require, "cange.lsp.server_configurations." .. server)
  local default_config = {
    on_attach = custom.on_attach,
    capabilities = custom.capabilities(),
    name = server, -- for log messages
  }
  if found_config then
    server_config = vim.tbl_deep_extend("force", server_config, default_config)
  else
    server_config = default_config
  end
  -- vim.pretty_print(provider, 'config', vim.tbl_keys(config))
  if found_typescript and server == "tsserver" then
    typescript.setup({ server = server_config })
  else
    config[server].setup(server_config)
  end
end

local servers = Cange.get_config("lsp.server_sources") or {}
for _, server in pairs(servers) do
  setup_server(server, lspconfig)
end
