local ns = "[cange.utils]"

---Provides general access to certain core sources
---@class Utils
local M = {}

M.get_icon = require("cange.utils.icons").get_icon
M.get_random_greeting_for = require("cange.utils.greetings").random_with_name
M.set_whichkey_group = require("cange.utils.whichkey_groups").set_group
M.get_whichkey_group = require("cange.utils.whichkey_groups").get_group
--
---Set highlight group by given table.
---@param highlights HighlightGroups Highlight definition map
---@see vim.api.nvim_set_hl
function M.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

---Provides mapping for highlight groups of symbol items.
---@param id? string|nil
---@return table A certain highlight group or all if identifier is nil
function M.get_symbol_kind_hl(id)
  id = id or nil
  local groups = require("cange.utils.hl_groups")
  local hls = vim.tbl_extend("keep", groups.kinds, groups.other_kinds)

  return id and hls[id] or hls
end

---Get certain config attributes
---@param key_path string Dot separated path to a certain config value.
---@return any value of given key or nil if not found.
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

---Pretty print shorthand
---@param value any
---@param ... any
function P(value, ...)
  vim.pretty_print(value, ...)
end

---Reruns a module file by removing the given module first
---@param module_name string
---@return table|any
function M.reload(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

---Adds an value to the global namespace, raises an error if key already exists
---@param key string
---@param value any
---@return any # Either registered or the value of taken key
function M.register_key(key, value)
  if M[key] ~= nil then
    vim.pretty_print(ns, '"' .. key .. '" key already taken')
  else
    M[key] = value
  end

  return M[key]
end

return M
