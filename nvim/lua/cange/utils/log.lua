local M = {}

---@enum cange.logLevels
M.levels = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}

---@class cange.logOptions
---@field title? string
---@field level? cange.logLevels

---@param msg string message
---@param opts? cange.logOptions
function M.log(msg, opts)
  opts = opts or {}
  local title = opts.title ~= nil and type(opts.title) == "string" and opts.title or ""
  vim.notify(" " .. msg, opts.level or M.levels.INFO, { title = title })
end

return M
