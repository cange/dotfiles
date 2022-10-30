local ns = "cange.lsp.mason"
local found, mason = pcall(require, "mason")
if not found then
  print("[" .. ns .. '] "mason" not found')
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print("[" .. ns .. '] "cange.utils" not found')
  return
end
-- config
mason.setup({
  ui = {
    border = "rounded",
    icons = utils.get_icon("mason"),
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
--
-- LSP-Config
local found_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not found_lspconfig then
  print("[" .. ns .. '] "mason-lspconfig" not found')
  return
end

-- config
-- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
mason_lspconfig.setup({
  ensure_installed = utils.get_config("lsp.server.sources") or {},
  automatic_installation = true,
})
--
-- Null-Ls-Config
local found_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not found_mason_null_ls then
  print("[" .. ns .. '] "mason-null-ls" not found')
  return
end

-- config
-- https://github.com/jayp0521/mason-null-ls.nvim#default-configuration
mason_null_ls.setup({
  ensure_installed = utils.get_config("lsp.null_ls.sources") or {},
  automatic_installation = true,
})
