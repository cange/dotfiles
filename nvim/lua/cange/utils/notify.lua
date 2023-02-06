---@class Cange.utils.Notify

---@type Cange.utils.Notify
local m = {}

---@param msg string
---@param title? string
function m.info(msg, title)
  title = title ~= nil and type(title) == "string" and title or ""
  vim.notify(msg, vim.log.levels.INFO, { title = title })
end

return m
