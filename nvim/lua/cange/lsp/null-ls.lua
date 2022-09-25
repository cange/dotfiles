local lsp = Cange.bulk_loader('null-ls', { { 'null-ls', 'null_ls' } })

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = lsp.null_ls.builtins.diagnostics
local formatting = lsp.null_ls.builtins.formatting
-- local code_actions = lsp.null_ls.builtins.code_actions

lsp.null_ls.setup({
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
