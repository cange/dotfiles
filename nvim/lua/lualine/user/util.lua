local M = {}

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
