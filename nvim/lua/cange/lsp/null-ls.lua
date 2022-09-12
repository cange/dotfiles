local found_null_ls, null_ls = pcall(require, 'null-ls')
if not found_null_ls then return end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
-- local function formatting_handler()
--   local timeout = 10000 -- milliseconds
--   print('Formatting…')
--   vim.lsp.buf.formatting_seq_sync({}, timeout)
--   vim.notify('Formatting…')
-- end

local settings = {
  debug = true,
  on_attach = function()
    vim.keymap.set({ 'n', 'v' }, '=', ':lua vim.lsp.buf.formatting_seq_sync()<CR>', { noremap = true, silent = true })
  end,
  sources = {
    -- formatting
    formatting.eslint_d, -- fast eslint
    formatting.markdownlint, -- style and syntax checker
    formatting.prettierd, -- pretty fast prettier
    formatting.shfmt,
    formatting.stylelint,
    formatting.yamlfmt,

    -- diagnostics/linter
    diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    diagnostics.jsonlint,
    diagnostics.rubocop,
    diagnostics.shellcheck,
    diagnostics.markdownlint, -- markdown style and syntax checker
    diagnostics.stylelint,
    diagnostics.yamllint,
    diagnostics.zsh,
  },
}
null_ls.setup(settings)
