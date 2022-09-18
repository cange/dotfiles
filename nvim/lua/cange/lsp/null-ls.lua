local found_null_ls, null_ls = pcall(require, 'null-ls')
if not found_null_ls then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
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
}
null_ls.setup(settings)
