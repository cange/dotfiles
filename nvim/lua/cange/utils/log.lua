---@type CangeLog
local M = {}

---@enum CangeLogLevels
M.levels = {
  DEBUG = 1,
  ERROR = 4,
  INFO = 2,
  OFF = 5,
  TRACE = 0,
  WARN = 3,
}

---@class CangeLog.options
---@field title? string
---@field level? CangeLogLevels|nil

---@param msg string message
---@param opts? CangeLog.options
function M.log(msg, opts)
  opts = opts or {}
  local title = opts.title ~= nil and type(opts.title) == "string" and opts.title or ""
  vim.notify(" " .. msg, opts.level or M.levels.INFO, { title = title })
end

return M
