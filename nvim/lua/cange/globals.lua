local ns = "[cange.globals]"
local found, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if found then
  reloader = plenary_reload.reload_module
end
local found_utils, utils = pcall(require, "cange.core.utils")
if not found_utils then
  print(ns, '"cange.core.utils" not found')
  return
end

---Pretty print shorthand
---@param value any
---@param ... any
---@return any Returns passt value in order to allow chaining
function P(value, ...)
  vim.pretty_print(value, ...)
  return value
end

function RELOAD(...)
  return reloader(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end

Cange = utils
