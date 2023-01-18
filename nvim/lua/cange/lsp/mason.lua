-- local ns = "[cange.lsp.mason]"
require("mason").setup({
  ui = {
    border = "rounded",
    icons = Cange.get_icon("mason"),
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
--
-- LSP-Config
-- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = Cange.get_config("lsp.server_sources"),
})

-- Null-Ls-Config
-- https://github.com/jayp0521/mason-null-ls.nvim#default-configuration
local null_ls_sources = Cange.get_config("lsp.null_ls_sources")
require("mason-null-ls").setup({
  automatic_installation = true,
  ensure_installed = null_ls_sources,
})

---Install all necessary packages at once
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(null_ls_sources, " "))
end, {})
