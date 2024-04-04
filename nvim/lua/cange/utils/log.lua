local M = {}
M.__index = M

function M:new()
  return setmetatable({
    plugin = "cange",
  }, self)
end

--- Adds a log entry using Plenary.log
---@param level integer [same as vim.log.levels]
---@param msg any
---@param opts any Options for notify
function M:add_entry(level, msg, opts)
  opts = opts or {}
  opts.title = opts.title ~= nil and type(opts.title) == "string" and opts.title or ""
  msg = vim.tbl_contains({ "minimal", "compact" }, opts.render or "") and msg or " " .. msg
  vim.notify(string.format("[%s] %s", self.plugin, msg), level, opts)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function M:debug(msg, event) self:add_entry(vim.log.levels.DEBUG, msg, event) end

---Add a log entry at INFO level
---@param msg any
---@param title any
function M:info(msg, title) self:add_entry(vim.log.levels.INFO, msg, { title = title, render = "compact" }) end

---Add a log entry at WARN level
---@param msg any
---@param opts any
function M:warn(msg, opts) self:add_entry(vim.log.levels.WARN, msg, opts) end

return M
