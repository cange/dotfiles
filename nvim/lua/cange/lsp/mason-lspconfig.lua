local ns = "cange.lsp.mason-lspconfig"
local found_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not found_lspconfig then
  print("[" .. ns .. '] "mason-lspconfig" not found')
  return
end
local found_servers, servers = pcall(require, "cange.lsp.servers")
if not found_servers then
  print("[" .. ns .. '] "cange.utils.servers" not found')
  return
end
-- config
mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = servers,
  -- A list of provide to automatically install if they're not already
  -- installed. Example: { "rust_analyzer@nightly", "sumneko_lua" } This
  -- setting has no relation with the `automatic_installation` setting.
  automatic_installation = true,
})
