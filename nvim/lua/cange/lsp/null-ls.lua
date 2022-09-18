local lsp = BULK_LOADER('null-ls', {
  { 'null-ls', 'null_ls' },
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = lsp.null_ls.builtins.diagnostics
local completion = lsp.null_ls.builtins.completion
local formatting = lsp.null_ls.builtins.formatting

lsp.null_ls.setup({
  debug = true,
  on_attach = function()
    vim.keymap.set({ 'n', 'v' }, '=', ':lua vim.lsp.buf.formatting_seq_sync()<CR>', { noremap = true, silent = true })
  end,
  sources = {
    -- formatting
    formatting.eslint_d, -- fast eslint
    formatting.prettierd, -- pretty fast prettier
    formatting.shfmt, -- shell
    formatting.stylelint, -- CSS
    formatting.stylua, -- lua

    -- diagnostics/linter
    diagnostics.eslint_d,
    diagnostics.jsonlint,
    diagnostics.shellcheck,
    diagnostics.stylelint, -- CSS
    diagnostics.zsh,

    -- completion
    completion.luasnip, -- snippets
  },
})
