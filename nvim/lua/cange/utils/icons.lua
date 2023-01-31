---@class Cange.utils.Icons

---@type Cange.utils.Icons
local m = {}
local ns = "[cange.utils.icons]"

---@param name string
---@return string|nil
local function get_single_icon(icon_list, name)
  local result = icon_list and icon_list[name] or nil

  if not result then
    vim.pretty_print(ns, name, "not found")
    return nil
  end
  return result
end

---@param group_id string Dot separated identifier path of `Cange.core.icons`
---@param ... string|table List of parts the actual icon path. Use last argument as options if tables i past
---@return string|Cange.core.icons|nil # The icon symbol or nil if not found
function m.get_icon(group_id, ...)
  local icons = require("cange.core.icons")
  -- local opts = {}
  local parts = { ... }
  local last_item = parts[#parts]

  if type(last_item) == "table" then
    -- opts = vim.deepcopy(last_item)
    table.remove(parts, #parts)
  end

  local group_parts = vim.split(group_id, "%.")
  if #group_parts > 1 then
    parts = vim.list_extend(group_parts, parts)
    group_id = table.remove(parts, 1)
  end

  ---@diagnostic disable-next-line: cast-local-type
  icons = get_single_icon(icons, group_id)
  if #parts > 0 then
    for _, icon_name in ipairs(parts) do
      ---@diagnostic disable-next-line: cast-local-type, param-type-mismatch
      icons = get_single_icon(icons, icon_name)
    end
  end


  if type(icons) == "string" then
    ---@diagnostic disable-next-line: cast-local-type
    icons = vim.trim(icons)
  end

  return icons
end

return m
