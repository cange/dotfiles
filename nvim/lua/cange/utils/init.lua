local ns = "[cange.utils]"

local M = {}

M.log = require("cange.utils.log").log
M.get_icon = require("cange.utils.icons").get_icon

---Get certain config attributes
---@param key_path string Dot separated path of config group
---@return cange.configGroup|any value of given key or nil if not found.
function M.get_config(key_path)
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

---Assigns the given value to the global config table
---@param key string
---@param value any
---@return any # Either registered or the value of taken key
function M.set_config(key, value)
  local config = require("cange.config")

  local parts = {}
  for part in string.gmatch(key, "[%w_]+") do
    table.insert(parts, part)
  end

  local last_key = table.remove(parts)

  for _, part in ipairs(parts) do
    if config[part] == nil then
      config[part] = {}
    elseif type(config[part]) ~= "table" then
      print(ns, "set_config", "Cannot set subkey of non-table value")
    end
    config = config[part]
  end

  config[last_key] = value

  return config[last_key]
end

---Pretty print shorthand
---@param value any
---@param ... any
function P(value, ...) vim.print(value, ...) end

---Reruns a module file by removing the given module first
---@param module_name string
---@return table|any
function M.reload(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

---@param highlights table<string, table>
---@see vim.api.nvim_set_hl
function M.set_highlights(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

return M
