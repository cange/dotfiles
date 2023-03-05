---@type CangeUtil.Notify
local M = {}

---@param msg string
---@param title? string
function M.info(msg, title)
  title = title ~= nil and type(title) == "string" and title or ""
  vim.notify(" " .. msg, vim.log.levels.INFO, { title = title })
end

return M
