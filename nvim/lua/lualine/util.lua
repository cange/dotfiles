local M = {}

---Truncates a string when longer than maximum length
---@param content string
---@param max_len number
---@return string
function M.truncate(content, max_len)
  if max_len == 0 then return "" end
  return #content > max_len and string.sub(content, 1, max_len - 1) .. "…" or content
end

---Ensures unique values within a string like table
---@param list string[]
---@return string[]
function M.list_dedupe(list)
  local result = {}
  local seen = {}
  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end
  return result
end

return M
