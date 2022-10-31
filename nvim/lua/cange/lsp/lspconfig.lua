local ns = "[cange.lsp.lspconfig]"
local found_lspconfig, lspconfig = pcall(require, "lspconfig")
if not found_lspconfig then
  print(ns, '"lspconfig" not found')
  return
end
local found_custom, custom = pcall(require, "cange.lsp.custom")
if not found_custom then
  print(ns, '"cange.lsp.custom" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end

local function setup_server(server, server_config)
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

  server_config[server].setup(config)
end

local servers = utils.get_config("lsp.server_sources") or {}
for _, server in pairs(servers) do
  setup_server(server, lspconfig)
end

-- Enable TypeScript/JS basic LSP feature via plugin
-- https://github.com/jose-elias-alvarez/typescript.nvim#setup
local found_typescript, typescript = pcall(require, "typescript")
if not found_typescript then
  print(ns, ' "typescript" not found')
  return
end

typescript.setup({
  server = {
    capabilities = custom.capabilities(),
    on_attach = custom.on_attach,
  },
})
