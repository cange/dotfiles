local ns = "cange.lsp.null-ls"
local found_null_ls, null_ls = pcall(require, "null-ls")
if not found_null_ls then
  print("[" .. ns .. '] "null-ls" not found')
  return
end
-- config
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
-- local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.stylua,
    formatting.prettierd, -- pretty fast prettier

    diagnostics.stylelint,
    diagnostics.eslint_d,
    diagnostics.jsonlint,

    -- formatting.stylelint,
    -- formatting.eslint_d,
    -- code_actions.eslint_d,
  },
})
