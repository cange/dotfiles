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
  if ft ~= "" then before_ft = ft end

  if cache[ft] then return formatter_callback(cache[ft]) end
  local data = fetch_callback()
  if #data > 0 then cache[ft] = data end
  return formatter_callback(cache[ft] or {})
end

return M
