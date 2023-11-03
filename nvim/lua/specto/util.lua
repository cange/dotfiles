local M = {}

---@param patterns string[]|nil
---@return boolean
local function has_file_name_support(patterns)
  if patterns == nil then return false end
  for _, p in ipairs(patterns) do
    if vim.fn.expand("%"):match(p) then return true end
  end
  return false
end

---@param lang_name string
---@param languages SpectoLanguage[]
---@return SpectoLanguage[]|nil
function M.get_language_props(lang_name, languages)
  assert(lang_name, '"lang_name" is required!')
  local language = languages[lang_name]
  if not language then return end
  return {
    file_patterns = language.file_patterns or nil,
    features = vim.tbl_deep_extend("force", languages["*"].features, language.features),
  }
end

---@param type SpectoType
---@param lang_name string
---@param lang_config SpectoLanguage
---@return boolean
function M.supported(type, lang_name, lang_config)
  local has_language_support = lang_config ~= nil and lang_config.features ~= nil
  local msg = has_language_support and "" or string.format("%q is not supported!", lang_name)
  if #msg == 0 and not has_file_name_support(lang_config.file_patterns) then
    msg = string.format("File name %q is not supported!", vim.fn.expand("%:t"))
  end
  if #msg == 0 and not lang_config.features[type] then
    msg = string.format('"%s()" does not support %q!', type, lang_name)
  end
  local supported = #msg == 0
  if supported == false then M.notify(msg) end
  return supported
end

---@param props SpectoFeature Config of a feature (skip, only)
---@param keyword? string
---@return string
function M.generate_flag(props, keyword)
  local k = keyword or ""
  return props.prefix and props.flag .. props.separator .. k or k .. props.separator .. props.flag
end

---@param props SpectoFeature
---@param active_only? boolean|nil Expose only active keywords (xit, xdescribe, etc.)
---@return SpectoFeatureKeywords
function M.get_keywords(props, active_only)
  local keywords = {}
  for _, k in ipairs(props.keywords) do
    local flagged_keyword = M.generate_flag(props, k)
    if not active_only then table.insert(keywords, k) end
    if not vim.tbl_contains(keywords, flagged_keyword) then table.insert(keywords, flagged_keyword) end
  end
  return keywords
end

function M.notify(msg) vim.notify(msg, 2, { title = "Specto" }) end

return M
