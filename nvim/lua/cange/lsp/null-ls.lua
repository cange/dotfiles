local ns = "cange.lsp.null-ls"
local found_null_ls, null_ls = pcall(require, "null-ls")
if not found_null_ls then
  print("[" .. ns .. '] "null-ls" not found')
  return
end
-- config
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

local function lsp_format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
    async = true, -- do not block if true
  })
end

local function on_save_formatting(bufnr)
  local group = vim.api.nvim_create_augroup("cange_lsp_formatting", { clear = true })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      lsp_format(bufnr)
    end,
  })
end
local function execute_path(shim)
  ---@see https://asdf-vm.com/manage/versions.html#shims
  return vim.fn.expand("$HOME/.asdf/shims/" .. shim)
end

null_ls.setup({
  update_in_insert = false, -- if true, it runs diagnostics in insert mode, which impacts performance
  sources = {
    -- JS and more
    formatting.prettierd.with({ command = execute_path("prettierd") }),

    -- CSS
    diagnostics.stylelint,
    formatting.stylelint,

    -- JS
    code_actions.eslint_d,
    diagnostics.eslint_d,
    formatting.eslint_d.with({ command = execute_path("eslint_d") }),

    -- JSON
    diagnostics.jsonlint,

    -- LUA
    formatting.stylua,

    -- RUBY
    diagnostics.rubocop,
    formatting.rubocop.with({ command = execute_path("rubocop") }),

    -- YAML
    diagnostics.yamllint,
    formatting.yamlfmt,

    -- ZSH
    diagnostics.zsh,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      on_save_formatting(bufnr)
    end
  end,
})
