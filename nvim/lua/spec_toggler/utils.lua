local ns = "spec_toggler"
local M = {}
local lang = require("nvim-treesitter.parsers").get_parser():lang()
local config = require("spec_toggler.config")

---@param msg string
local function notify(msg) vim.notify(msg, 2, { title = ns }) end

---@return SpecTogglerFeature[]|nil
local function get_features()
  if config[lang] == nil then return end
  return vim.tbl_deep_extend("force", config["*"].features, config[lang].features)
end

---@param type '"only"'|'"skip"'
---@return boolean
function M.supported(type)
  local supported = config[lang] and config[lang].features[type] ~= nil
  if not supported then notify(type .. '() is not supported for "' .. lang .. '"') end
  return supported
end

M.debug = false
M.features = get_features()


---@param type string
---@return table<string>
local function extend_keywords(type)
  ---@type SpecTogglerFeature
  local f = M.features[type]
  local keywords = {}
  for _, k in ipairs(f.keywords) do
    local keyword = f.prefix and f.flag .. f.separator .. k or k .. f.separator .. f.flag
    table.insert(keywords, k)
    if not vim.tbl_contains(keywords, keyword) then table.insert(keywords, keyword) end
  end
  return keywords
end

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
  return vim.tbl_contains(extend_keywords(type), M.name(node))
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
  local target = M.tree_walker(type, node:parent())
  if target == nil then notify(type .. "() no target found!") end
  return target
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

---@class SpecTogglerFeature
---@field keywords table
---@field flag string
---@field separator string
---@field prefix boolean
