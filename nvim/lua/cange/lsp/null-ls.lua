-- local ns = "[cange.lsp.null-ls]"
local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

local function execute_path(shim)
  ---@see https://asdf-vm.com/manage/versions.html#shims
  return vim.fn.expand("$HOME/.asdf/shims/" .. shim)
end

null_ls.setup({
  update_in_insert = false, -- if true, it runs diagnostics in insert mode, which impacts performance
  sources = {
    -- js, ts, vue, css, html, json, yaml, md etc.
    formatting.prettierd.with({ command = execute_path("prettierd") }),

    -- js
    code_actions.eslint_d.with({ command = execute_path("eslint_d") }),
    formatting.eslint_d.with({ command = execute_path("eslint_d") }),
    require("typescript.extensions.null-ls.code-actions"),

    -- json
    diagnostics.jsonlint,

    -- lua
    formatting.stylua,

    -- ruby
    diagnostics.rubocop.with({ command = execute_path("rubocop") }),
    formatting.rubocop.with({ command = execute_path("rubocop") }),

    diagnostics.yamllint,
    diagnostics.zsh,
  },
})
