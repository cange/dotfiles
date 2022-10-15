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

null_ls.setup({
  update_in_insert = false, -- if true, it runs diagnostics in insert mode, which impacts performance
  sources = {
    formatting.stylua,
    formatting.prettierd.with({ -- pretty fast prettier
      command = vim.fn.expand("$HOME/.asdf/shims/prettierd"),
    }),
    formatting.stylelint,
    formatting.eslint_d.with({
      command = vim.fn.expand("$HOME/.asdf/shims/eslint_d"),
    }),

    diagnostics.stylelint,
    diagnostics.eslint_d,
    -- diagnostics.eslint_d.with({
    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    -- }),
    diagnostics.jsonlint,

    code_actions.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("CangeLspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})
