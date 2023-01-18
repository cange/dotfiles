-- local ns = "[cange.lsp.lspconfig]"
local common = Cange.reload("cange.lsp.common")

---Sets up individual LSP server
---@param server string name of the particular server
local function setup_server(server)
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

  if server == "tsserver" then
    -- Enable TypeScript/JS basic LSP feature via plugin
    -- https://github.com/jose-elias-alvarez/typescript.nvim#setup
    require("typescript").setup({ server = server_config })
  else
    require("lspconfig")[server].setup(server_config)
  end
end

for _, source in pairs(Cange.get_config("lsp.server_sources")) do
  setup_server(source)
end
