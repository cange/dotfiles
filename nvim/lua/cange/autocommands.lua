-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  group = augroup("cange_remove_whitespace_on_save", { clear = true }),
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

autocmd({ "VimEnter" }, {
  group = augroup("cange_highlight_word_under_cursor", { clear = true }),
  callback = function()
    vim.cmd("hi link illuminatedWord LspReferenceText")
  end,
})
