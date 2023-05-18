local Log = {}

Log.levels = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}

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
function Log:trace(msg, event) self:add_entry(self.levels.TRACE, msg, event) end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event) self:add_entry(self.levels.DEBUG, msg, event) end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event) self:add_entry(self.levels.INFO, msg, event) end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event) self:add_entry(self.levels.WARN, msg, event) end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event) self:add_entry(self.levels.ERROR, msg, event) end

setmetatable({}, Log)

return Log
