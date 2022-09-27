---@module 'keymaps'

---Provides keymap convenience helpers
local M = {}

---@see vim.keymap.set()
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
