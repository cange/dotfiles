-- collection of string utils
local M = {}

---Truncates a string when longer than maximum length
---@param content string
---@param max_len number
---@return string
function M.truncate(content, max_len)
  if max_len == 0 then return "" end
  return #content > max_len and string.sub(content, 1, max_len - 1) .. "…" or content
end

---Add whitespace to a string
---@param str string
---@param opts {left?:number, right?:number}
---@return string
function M.pad(str, opts)
  local left = string.rep(" ", opts.left or 0)
  local right = string.rep(" ", opts.right or 0)
  return left .. str .. right
end

return M
