local ns = "[cange.utils.icons_helper]"
local all_icons = require("cange.utils.icons")

---@param icon_list CoreIcons|CoreIcon
---@param name string
---@return CoreIcon|nil
local function get_single_icon(icon_list, name)
  local result = icon_list and icon_list[name] or nil
  if not result then
    vim.pretty_print(ns, name, "not found")
    return nil
  end
  return result
end

local M = {}

---@param group_id string Identifier of the icon group
---@param ... string|table List of parts the actual icon path. Use last argument as options if tables i past
---@return CoreIcon|table|nil # The icon symbol or nil if not found
function M.get_icon(group_id, ...)
  local icons = all_icons
  local opts = {}
  local parts = { ... }
  local last_item = parts[#parts]

  if type(last_item) == "table" then
    opts = vim.deepcopy(last_item)
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
    if opts.trim ~= nil and opts.trim then
      ---@diagnostic disable-next-line: cast-local-type
      icons = vim.trim(icons)
    end
  end

  return icons
end

return M
