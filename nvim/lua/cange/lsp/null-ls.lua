-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

null_ls.setup({
  update_in_insert = false, -- if true, it runs diagnostics in insert mode, which impacts performance
  sources = {
    -- js, ts, vue, css, html, json, yaml, md etc.
    formatting.prettierd,

    -- js
    code_actions.eslint_d,
    formatting.eslint_d,
    require("typescript.extensions.null-ls.code-actions"),

    -- json
    diagnostics.jsonlint,

    -- lua
    formatting.stylua,

    -- ruby
    diagnostics.rubocop,
    formatting.rubocop,

    diagnostics.yamllint,
    diagnostics.zsh,
  },
})
