local ns = "[cange.lsp.null-ls]"
local found_null_ls, null_ls = pcall(require, "null-ls")
if not found_null_ls then
  print(ns, '"null-ls" not found')
  return
end
-- config
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

local found_ts_code_actions, ts_code_actions = pcall(require, "typescript.extensions.null-ls.code-actions")
if not found_ts_code_actions then
  print(ns, '"typescript.extensions.null-ls.code-actions" not found')
end

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
    diagnostics.eslint_d.with({ command = execute_path("eslint_d") }),
    formatting.eslint_d.with({ command = execute_path("eslint_d") }),
    ts_code_actions,

    -- json
    diagnostics.jsonlint,

    -- lua
    formatting.stylua,

    -- ruby
    diagnostics.rubocop.with({ command = execute_path("rubocop") }),
    formatting.rubocop.with({ command = execute_path("rubocop") }),

    -- yaml
    diagnostics.yamllint,

    -- zsh
    diagnostics.zsh,
  },
})
