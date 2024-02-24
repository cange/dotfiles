-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("CangeSetup", { clear = true })

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = "*.md,*.lua,*.txt",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80
  end,
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = ".env.*",
  callback = function() vim.bo.filetype = "sh" end,
})

autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
  group = group_id,
  pattern = "*.mdx",
  callback = function() vim.bo.filetype = "jsx" end,
})
