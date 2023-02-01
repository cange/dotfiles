local ns = "[cange.utils]"

---@class Cange.utils
---@field Icons Cange.utils.Icons
---@field whichkey Cange.utils.whichkey
---@field palette table

---@type Cange.utils
local m = {}

m.get_icon = require("cange.utils.icons").get_icon
m.set_whichkey_group = require("cange.utils.whichkey_groups").set_group
m.get_whichkey_group = require("cange.utils.whichkey_groups").get_group

---Set highlight group by given table.
---@param highlights Cange.core.highlight_groups Highlight definition map
---@see vim.api.nvim_set_hl
function m.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

---Provides mapping for highlight groups of symbol items.
---@param id? string|nil
---@return table A certain highlight group or all if identifier is nil
function m.get_symbol_kind_hl(id)
  id = id or nil
  local groups = require("cange.core.hl_groups")
  local hls = vim.tbl_extend("keep", groups.kinds, groups.other_kinds)

  return id and hls[id] or hls
end

---Get certain config attributes
---@param key_path string Dot separated identifier path of  `Cange.config`
---@return Cange.config value of given key or nil if not found.
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
