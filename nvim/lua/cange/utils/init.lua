local ns = "[cange.utils]"
local config = require("cange.config")
local icons = require("cange.utils.icons")
local whichkey_groups = require("cange.utils.whichkey_groups")
local greetings = require("cange.utils.greetings")
local hl_groups = require("cange.utils.hl_groups")

---Provides general access to certain core sources
---@class Utils

local M = {}

M.get_random_greeting_for = greetings.random_with_name
M.set_whichkey_group = whichkey_groups.set_group
M.get_whichkey_group = whichkey_groups.get_group
--
---Set highlight group by given table.
---@param highlights HighlightGroups Highlight definition map
---@see vim.api.nvim_set_hl
function M.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

---@param icon_list CoreIcons|CoreIcon
---@param name string
---@return CoreIcon|nil
local function get_single_icon(icon_list, name)
  local result = icon_list and icon_list[name] or nil
  if not result then
    vim.pretty_print("[cange.uils.icons] icon", name, "not found")
    return nil
  end
  return result
end

---Ensures that the icons of given parts exists
---@param group_id string Identifier of the icon group
---@param ... string|table List of parts the actual icon path. Use last argument as options if tables i past
---@return CoreIcon|nil The icon symbol or nil if not found
function M.get_icon(group_id, ...)
  local icon_list = icons
  local opts = {}
  local parts = { ... }
  local last_item = parts[#parts]

  if type(last_item) == "table" then
    opts = vim.deepcopy(last_item)
    table.remove(parts, #parts)
  end

  local group_parts = vim.split(group_id, ".", { plain = true })
  if #group_parts > 1 then
    parts = vim.list_extend(group_parts, parts)
    group_id = table.remove(parts, 1)
  end

  ---@diagnostic disable-next-line: cast-local-type
  icon_list = get_single_icon(icon_list, group_id)
  if #parts > 0 then
    for _, icon_name in ipairs(parts) do
      ---@diagnostic disable-next-line: cast-local-type, param-type-mismatch
      icon_list = get_single_icon(icon_list, icon_name)
    end
  end

  if type(icon_list) == "string" and opts.trim ~= nil and opts.trim then
    ---@diagnostic disable-next-line: cast-local-type
    icon_list = vim.trim(icon_list)
  end

  return icon_list
end

---Provides mapping for highlight groups of symbol items.
---@param id? string|nil
---@return table A certain highlight group or all if identifier is nil
function M.get_symbol_kind_hl(id)
  id = id or nil
  local hls = vim.tbl_extend("keep", hl_groups.kinds, hl_groups.other_kinds)

  return id and hls[id] or hls
end

---Get certain config attributes
---@param key_path string Dot separated path to a certain config value.
---@return any value of given key or nil if not found.
function M.get_config(key_path)
  local config_prop = config
  local separator = "%."

  for _, key in pairs(vim.split(key_path, separator)) do
    if config_prop[key] then
      ---@diagnostic disable-next-line: cast-local-type
      config_prop = config_prop[key]
    end
  end

  if config_prop == nil then
    print(ns, 'of "' .. key_path .. '" key is not configured!')
  end

  return config_prop
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
