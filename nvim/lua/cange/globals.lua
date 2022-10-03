local found, plenary_reload = pcall(require, 'plenary.reload')
local reloader = require
if found then
  reloader = plenary_reload.reload_module
end

---Pretty print shorthand
---@param ... any
---@return any Returns passt value in order to allow chaining
function P(...)
  vim.pretty_print(...)
  return value
end

function RELOAD(...)
  return reloader(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end
