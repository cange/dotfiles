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

local found_common, common = pcall(Cange.reload, "cange.lsp.common")
if not found_common then
  print(ns, '"cange.lsp.common" not found')
  return
end

local function setup_server(server, config)
  local found_config, server_config = pcall(require, "cange.lsp.server_configurations." .. server)
  local default_config = {
    on_attach = common.on_attach,
    capabilities = common.capabilities(),
    name = server, -- for log messages
  }

  if found_config then
    server_config = vim.tbl_deep_extend("force", server_config, default_config)
  else
    server_config = default_config
  end

  if found_typescript and server == "tsserver" then
    typescript.setup({ server = server_config })
  else
    config[server].setup(server_config)
  end
end

for _, source in pairs(Cange.get_config("lsp.server_sources")) do
  setup_server(source, lspconfig)
end
