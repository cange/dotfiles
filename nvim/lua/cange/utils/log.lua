local Log = {}

--- Adds a log entry using Plenary.log
---@param level integer [same as vim.log.levels]
---@param msg any
---@param event any
function Log:add_entry(level, msg, event)
  event = event or {}
  local title = event.title ~= nil and type(event.title) == "string" and event.title or ""
  vim.notify(" " .. msg, level, { title = title })
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event) self:add_entry(vim.log.levels.TRACE, msg, event) end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event) self:add_entry(vim.log.levels.DEBUG, msg, event) end

---Add a log entry at INFO level
---@param msg any
---@param title any
function Log:info(msg, title) self:add_entry(vim.log.levels.INFO, msg, { title = title }) end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event) self:add_entry(vim.log.levels.WARN, msg, event) end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event) self:add_entry(vim.log.levels.ERROR, msg, event) end

setmetatable({}, Log)

return Log
