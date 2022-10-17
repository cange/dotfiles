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
-- local code_actions = null_ls.builtins.code_actions

local function lsp_formatting(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end
local function on_save_formatting(bufnr)
  local group = vim.api.nvim_create_augroup("cange_lsp_formatting", { clear = true })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      lsp_formatting(bufnr)
    end,
  })
end

null_ls.setup({
  update_in_insert = false, -- if true, it runs diagnostics in insert mode, which impacts performance
  sources = {
    -- Multi-Languages
    formatting.prettierd.with({ -- pretty fast prettier
      command = vim.fn.expand("$HOME/.asdf/shims/prettierd"),
    }),

    -- CSS
    diagnostics.stylelint,
    formatting.stylelint,

    -- JS
    code_actions.eslint_d,
    diagnostics.eslint_d,
    -- diagnostics.eslint_d.with({
    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    -- }),

    -- JSON
    diagnostics.jsonlint,

    -- LUA
    formatting.stylua,

    -- RUBY
    diagnostics.rubocop,
    formatting.rubocop,

    -- YAML
    formatting.yamlfmt,
    diagnostics.yamllint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      on_save_formatting(bufnr)
    end
  end,
})
