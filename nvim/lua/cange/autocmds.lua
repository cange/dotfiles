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

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = group_id,
  callback = function() vim.highlight.on_yank({ higroup = "Cursor" }) end,
})

-- Show project picker on startup
autocmd({ "VimEnter" }, {
  group = group_id,
  callback = function()
    local ok, telescope = pcall(require, "telescope")
    if not ok then return end
    if not telescope.extensions.project then return end
    telescope.extensions.project.project({})
  end,
})
