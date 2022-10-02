local ns = 'cange.utils.init'
local found_greetings, greetings = pcall(require, 'cange.utils.greetings')
if not found_greetings then
  print('[' .. ns .. '] "cange.utils.greetings" not found')
  return
end
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
---@module 'utils'

---Provides keymap convenience helpers
local M = {}

---@see vim.keymap.set()
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.greetings = greetings
M.icons = icons

return M
