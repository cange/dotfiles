local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then return end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local completion = null_ls.builtins.completion
-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
local settings = {
  debug = true,
  sources = {
    formatting.esint_d, -- Injects actions to fix ESLint is_success, faster the regular eslint
    formatting.markdownlint, -- style and syntax checker
    formatting.prettier,
    formatting.shfmt,
    formatting.stylelint,
    formatting.stylua,
    formatting.yamlfmt,

    diagnostics.codespell, -- finds common misspellings
    diagnostics.eslint,
    diagnostics.jsonlint,
    diagnostics.luacheck,
    diagnostics.misspell,
    diagnostics.rubocop,
    diagnostics.shellcheck,
    diagnostics.stylelint,
    diagnostics.yamllint,
    diagnostics.zsh,

    completion.luasnip,
    completion.spell,

    code_actions.git_signs,
  },
}

null_ls.setup(settings)
