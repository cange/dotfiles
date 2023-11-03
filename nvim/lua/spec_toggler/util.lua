local ns = "spec_toggler"

---@param msg string
local function notify(msg) vim.notify(msg, 2, { title = ns }) end

---@param patterns string[]|nil
---@return boolean
local function has_file_name_support(patterns)
  if patterns == nil then return false end
  for _, p in ipairs(patterns) do
    if vim.fn.expand("%"):match(p) then return true end
  end
  return false
end

local Util = {}

---@type SpecTogglerLanguage[]
local langs = require("spec_toggler.config").languages

---@param lang string Language of file extension
---@param debug? boolean
function Util:new(lang, debug)
  local mt = setmetatable({}, { __index = self })
  self.lang = lang or ""
  self.debug = (debug or false)

  self:get_features()
  self:get_file_patterns()

  return mt
end

---@return string[]|nil
function Util:get_file_patterns()
  if langs[self.lang] == nil then return end
  self.file_patterns = langs[self.lang].file_patterns or nil
  return self.file_patterns
end

---@return SpecTogglerFeature[]|nil
function Util:get_features()
  if langs[self.lang] == nil then return end
  self.features = vim.tbl_deep_extend("force", langs["*"].features, langs[self.lang].features)
  return self.features
end

---@param type SpecTogglerType
---@return boolean
function Util:supported(type)
  -- assert(vim.tbl_contains(vim.tbl_keys(self.features), type), '"type" needs to be defined')
  -- PF("supported: -t: %q -l: %q -f: %q", type, self.lang, self.features)
  local has_language_support = langs[self.lang] ~= nil and self.features ~= nil
  local msg = has_language_support and "" or string.format("%q is not supported!", self.lang)
  if #msg == 0 and not has_file_name_support(self.file_patterns) then
    msg = string.format("File name %q is not supported!", vim.fn.expand("%:t"))
  end

  if #msg == 0 and not self.features[type] then msg = string.format('"%s()" does not support %q!', type, self.lang) end

  local supported = #msg == 0

  if supported == false then notify(msg) end
  return supported
end

---@param type SpecTogglerType
---@param active_only? boolean|nil Expose only active keywords (xit, xdescribe, etc.)
---@return table
function Util:get_keywords(type, active_only)
  ---@type SpecTogglerFeature
  local f = self.features[type]
  local keywords = {}
  for _, k in ipairs(f.keywords) do
    local keyword = f.prefix and f.flag .. f.separator .. k or k .. f.separator .. f.flag
    if not active_only then table.insert(keywords, k) end
    if not vim.tbl_contains(keywords, keyword) then table.insert(keywords, keyword) end
  end
  return keywords
end

---@param node TSNode
---@return string
function Util:name(node) return vim.treesitter.get_node_text(node, 0) end

---@param msg string
function Util:log(msg)
  if not self.debug then return end
  vim.print(msg)
end

---@param type SpecTogglerType
---@param node TSNode
---@return boolean
function Util:matches(type, node)
  if node == nil then return false end
  return vim.tbl_contains(self:get_keywords(type), self:name(node))
end

---@param type SpecTogglerType
---@param node TSNode
---@return TSNode|nil
function Util:tree_walker(type, node)
  if node == nil then
    return nil
  elseif self:matches(type, node) then
    return node
  elseif node:child_count() > 0 and self:matches(type, node:child()) then
    return node:child()
  end

  local target = self:tree_walker(type, node:parent())
  if target == nil then notify(string.format('"%s()" no target found!', type)) end
  return target
end

---@param node TSNode
---@param content string
---@param range? Range|nil
function Util:replace_text(node, content, range)
  local srow, scol, erow, ecol = node:range()
  scol = range and range.start_col or scol
  ecol = range and range.end_col or ecol
  vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, { content })
end

return Util

---@class Range
---@field start_col number
---@field end_col number

---@class SpecTogglerFeature
---@field keywords table
---@field flag string
---@field separator string
---@field prefix boolean

---@class SpecTogglerLanguage
---@field features SpecTogglerFeature[]
---@field file_patterns string[]

---@alias SpecTogglerType '"only"'|'"skip"'
