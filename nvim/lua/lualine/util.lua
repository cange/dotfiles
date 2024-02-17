local M = {}

---Truncates a string when longer than maximum length
---@param content string
---@param max_len number
---@return string
function M.truncate(content, max_len)
  if max_len == 0 then return "" end
  return #content > max_len and string.sub(content, 1, max_len - 1) .. "…" or content
end

return M
