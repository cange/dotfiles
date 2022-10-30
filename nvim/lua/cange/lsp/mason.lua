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
--
-- Null-Ls-Config
local found_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not found_mason_null_ls then
  print("[" .. ns .. '] "mason-null-ls" not found')
  return
end
-- config
mason_null_ls.setup({
  -- A list of sources to install if they're not already installed.
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "eslint_d",
    "jsonlint",
    "prettierd",
    "rubocop",
    "stylua",
    "yamllint",
    "zsh",
  },
  -- Will automatically install masons tools based on selected sources in `null-ls`.
  -- Can also be an exclusion list.
  -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
  automatic_installation = true,
})
