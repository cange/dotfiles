-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Formatting
autocmd("BufWritePre", {
  group = augroup("cange_remove_whitespace_on_save", { clear = true }),
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = augroup("line_length", { clear = true }),
  pattern = "*.md,*.lua,*.txt",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80
  end,
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = augroup("mdx_filetype", { clear = true }),
  pattern = "*.mdx",
  callback = function() vim.bo.filetype = "jsx" end,
})

autocmd({ "BufWritePost" }, {
  group = augroup("cange_lsp_auto_format", { clear = true }),
  pattern = "*",
  desc = "File format",
  callback = R("cange.lsp").format,
})
