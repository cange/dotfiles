-- see https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/globals.lua

---Pretty print shorthand
---@param value any
---@param ... any
---@return any
function P(value, ...)
  vim.print(value, ...)
  return value
end

---@param ... any
---@return any
RELOAD = function(...)
  local reloader = require

  local ok_plenary, plenary_reload = pcall(require, "plenary.reload")
  if ok_plenary then reloader = plenary_reload.reload_module end

  return reloader(...)
end

---@param name string
---@return table
R = function(name)
  RELOAD(name)
  return require(name)
end
