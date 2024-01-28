local M = {}

---Provides a function to cache the result of a function
---@param cache table The storage of cached data
---@param before_ft string Last filetype before calling this function
---@param formatter_callback function The actual content to be displayed
---@param fetch_callback function The function to fetch the data
---@return string[]
function M.cached_status(cache, before_ft, formatter_callback, fetch_callback)
  local ft = vim.fn.expand("%:e")
  ft = ft ~= "" and ft or not before_ft and before_ft or "none"

  if cache[ft] then return formatter_callback(cache[ft]) end
  local data = fetch_callback()
  if #data > 0 then cache[ft] = data end
  return formatter_callback(cache[ft] or {})
end

---Truncates a string when longer than maximum length
---@param content string
---@param max_len number
---@return string
function M.truncate(content, max_len)
  if max_len == 0 then return "" end
  return #content > max_len and string.sub(content, 1, max_len - 1) .. "…" or content
end

return M
