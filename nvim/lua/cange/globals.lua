-- see https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/globals.lua

---Pretty print shorthand
---@param value any
---@param ... any
---@return any
function P(value, ...)
  vim.print(value, ...)
  return value
end

---Print format shorthand
---@param value any
---@param ... any
---@return any
function PF(value, ...)
  vim.print(string.format(value, ...))
  return value
end

---@param ... any
---@return any
local function reload(...)
  local reloader = require

  local ok_plenary, plenary_reload = pcall(require, "plenary.reload")
  if ok_plenary then reloader = plenary_reload.reload_module end

  return reloader(...)
end

---@param name string
---@return table
R = function(name)
  reload(name)
  return require(name)
end
