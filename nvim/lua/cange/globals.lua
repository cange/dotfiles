local found, plenary_reload = pcall(require, 'plenary.reload')
local reloader = require
if found then
  reloader = plenary_reload.reload_module
end

function P(v)
  print(vim.inspect(v))
  return v
end

function RELOAD(...)
  return reloader(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end
