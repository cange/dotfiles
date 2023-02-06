local ns = "[cange.utils]"

---@class Cange.utils

---@class Cange.utils.Utils

---@type Cange.utils.Utils
local m = {}

m.log = {
  info = require("cange.utils.notify").info,
}
m.get_icon = require("cange.utils.icons").get_icon
m.set_hls = require("cange.utils.highlights").set_hls

---Get certain config attributes
---@param key_path string Dot separated identifier path of `Cange.config`
---@return Cange.config|any value of given key or nil if not found.
function m.get_config(key_path)
  local prop = require("cange.config")

  for _, key in pairs(vim.split(key_path, "%.")) do
    local next_prop = prop[key]
    if next_prop ~= nil then
      ---@diagnostic disable-next-line: cast-local-type
      prop = next_prop
    end
  end

  return prop
end

---Pretty print shorthand
---@param value any
---@param ... any
function P(value, ...)
  vim.pretty_print(value, ...)
end

---Reruns a module file by removing the given module first
---@param module_name string
---@return table|any
function m.reload(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

---Adds an value to the global namespace, raises an error if key already exists
---@param key string
---@param value any
---@return any # Either registered or the value of taken key
function m.register_key(key, value)
  if m[key] ~= nil then
    vim.pretty_print(ns, '"' .. key .. '" key already taken')
  else
    m[key] = value
  end

  return m[key]
end

return m
