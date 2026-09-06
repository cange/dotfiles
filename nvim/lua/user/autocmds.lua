-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("user-setup", { clear = true })

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = group_id,
  callback = function() vim.hl.on_yank({ higroup = "Cursor" }) end,
})

autocmd("TermOpen", {
  desc = "Clean inner editor terminal",
  group = group_id,
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
