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

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("cange_line_length", { clear = true }),
  pattern = "*.md,*.mdx,*.lua,*.txt",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("cange_mdx_filetype", { clear = true }),
  pattern = "*.mdx",
  command = ":set filetype=markdown",
})

-- Indentation highlighting
autocmd({ "VimEnter" }, {
  group = augroup("cange_highlight_word_under_cursor", { clear = true }),
  callback = function() vim.cmd("hi link illuminatedWord LspReferenceText") end,
})
