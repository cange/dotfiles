local ns = "spec_toggler"
local lang = require("nvim-treesitter.parsers").get_parser():lang()
local config = require("spec_toggler.config")

---@param msg string
local function notify(msg) vim.notify(msg, 2, { title = ns }) end

---@return SpecTogglerFeature[]|nil
local function get_features()
  if config[lang] == nil then return end
  return vim.tbl_deep_extend("force", config["*"].features, config[lang].features)
end

---@return string[]|nil
local function get_file_patterns()
  if config[lang] == nil then return end
  return config[lang].file_patterns or nil
end

---@param patterns string[]|nil
---@return boolean
local function has_file_name_support(patterns)
  if patterns == nil then return false end
  for _, p in ipairs(patterns) do
    if vim.fn.expand("%"):match(p) then return true end
  end
  return false
end

local M = {}
M.debug = false
M.features = get_features()
M.file_patterns = get_file_patterns()

---@param type '"only"'|'"skip"'
---@return boolean
function M.supported(type)
  local has_language_support = config[lang] ~= nil and M.features ~= nil
  local msg = has_language_support and "" or string.format("%q is not supported!", lang)
  if #msg == 0 and not has_file_name_support(M.file_patterns) then
    msg = string.format("File name %q is not supported!", vim.fn.expand("%:t"))
  end
  if #msg == 0 and not M.features[type] then msg = string.format('"%s()" does not support %q!', type, lang) end

  local supported = #msg == 0

  if supported == false then notify(msg) end
  return supported
end

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
  if target == nil then notify(string.format('"%s()" no target found!', type)) end
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
