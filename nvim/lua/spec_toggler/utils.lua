local M = {}

M.debug = false
M.keywords = {
  skip = { "it", "describe", "test", "xit", "xdescribe", "xtest" },
  only = { "it", "describe", "test", "it.only", "describe.only", "test.only" },
}

---@param node TSNode
---@return string
function M.name(node) return vim.treesitter.get_node_text(node, 0) end

---@param msg string
function M.log(msg)
  if not M.debug then return end
  vim.print(msg)
end

---@param type '"skip"'|'"only"'
---@param node TSNode
---@return boolean
function M.matches(type, node)
  if node == nil then return false end
  return vim.tbl_contains(M.keywords[type], M.name(node))
end

---@param type '"skip"'|'"only"'
---@param node TSNode
---@return TSNode|nil
function M.tree_walker(type, node)
  if node == nil then
    return nil
  elseif M.matches(type, node) then
    return node
  elseif node:child_count() > 0 and M.matches(type, node:child()) then
    return node:child()
  end
  return M.tree_walker(type, node:parent())
end

---@class Range
---@field start_col number
---@field end_col number

---@param node TSNode
---@param content string
---@param range? Range|nil
function M.replace_text(node, content, range)
  local srow, scol, erow, ecol = node:range()
  scol = range and range.start_col or scol
  ecol = range and range.end_col or ecol
  vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, { content })
end

return M
