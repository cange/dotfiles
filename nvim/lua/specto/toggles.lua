local util = require("specto.util")
local M = {}

---@class ColumnRange
---@field start_col number
---@field end_col number

---@param node TSNode
---@param content string
---@param range? ColumnRange
function M.replace_text(node, content, range)
  local start_row, start_col, end_row, end_col = node:range()

  start_col = range and range.start_col or start_col
  end_col = range and range.end_col or end_col

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { content })
end

---@param feature_props SpectoFeature
---@return TSNode|nil
function M.get_node(feature_props)
  local keywords = util.get_keywords(feature_props)
  return M.tree_walker(keywords, vim.treesitter.get_node())
end

---@param node TSNode
---@return string
function M.get_node_name(node) return vim.treesitter.get_node_text(node, 0) end

---@param keywords SpectoFeatureKeywords
---@param node TSNode
---@return boolean
function M.matches(keywords, node)
  if node == nil then return false end
  return vim.tbl_contains(keywords, M.get_node_name(node))
end

---@param keywords SpectoFeatureKeywords
---@param node TSNode
---@return TSNode|nil
function M.tree_walker(keywords, node)
  if node == nil then
    return nil
  elseif M.matches(keywords, node) then
    return node
  elseif node:child_count() > 0 and M.matches(keywords, node:child()) then
    return node:child()
  end
  local target = M.tree_walker(keywords, node:parent())
  if target == nil then M.notify(string.format('"%s()" no target found!', keywords)) end
  return target
end

---@param features SpectoFeature[]
---@example it() => it.only() => it()
function M.only(features)
  local feature_props = features.only
  local node = M.get_node(feature_props)
  if node == nil then return end
  local flag = util.generate_flag(feature_props)
  local name = M.get_node_name(node)
  local active = name:match(flag) ~= nil
  local content = active and vim.split(name, flag)[1] or name .. flag
  if active then
    local _, scol, _, ecol = node:range()
    M.replace_text(node, content, { start_col = scol, end_col = ecol })
  else
    M.replace_text(node, content)
  end
end

---@param features SpectoFeature[]
---@example xit() => it() => xit()
function M.skip(features)
  local feature_props = features.skip
  local node = M.get_node(feature_props)
  if node == nil then return end
  local name = M.get_node_name(node)
  local content = name:find("^" .. feature_props.flag) == 1 and name:sub(2) or feature_props.flag .. name
  M.replace_text(node, content)
end

return M
