---@module 'keymaps'

---Provides keymap convenience helpers
local M = {}

---@see vim.keymap.set()
local function keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

---Gobal mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.map(lhs, rhs, opts)
  keymap('', lhs, rhs, opts)
end

---Insert mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.imap(lhs, rhs, opts)
  keymap('i', lhs, rhs, opts)
end

---Visual and select mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.vmap(lhs, rhs, opts)
  keymap('v', lhs, rhs, opts)
end

---Normal mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.nmap(lhs, rhs, opts)
  keymap('n', lhs, rhs, opts)
end

---- Visual mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.xmap(lhs, rhs, opts)
  keymap('x', lhs, rhs, opts)
end

---Normal and visual and select mode
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.nvmap(lhs, rhs, opts)
  keymap({ 'n', 'v' }, lhs, rhs, opts)
end

return M
