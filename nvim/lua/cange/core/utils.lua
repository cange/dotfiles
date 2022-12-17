local ns = "[cange.core.utils]"
---@module 'cange.core.utils'

---Provides general access to certain core sources
local M = {}

---Set highlight group by given table.
---@param highlights HighlightGroups Highlight definition map
---@see vim.api.nvim_set_hl
function M.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

local found_icons, icons = pcall(require, "cange.core.icons")
if found_icons then
  ---@param icon_list CoreIcons|CoreIcon
  ---@param name string
  ---@return CoreIcon|nil
  local function get_single_icon(icon_list, name)
    local result = icon_list and icon_list[name] or nil
    if not result then
      vim.pretty_print("[cange.core.icons] icon", name, "not found")
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
else
  print(ns, '"cange.core.icons" not found')
end

local found_hl_groups, hl_groups = pcall(require, "cange.core.hl_groups")
if found_hl_groups then
  ---Provides mapping for highlight groups of symbol items.
  ---@param id? string|nil
  ---@return table A certain highlight group or all if identifier is nil
  function M.get_symbol_kind_hl(id)
    id = id or nil
    local hls = vim.tbl_extend("keep", hl_groups.kinds, hl_groups.other_kinds)

    return id and hls[id] or hls
  end
else
  print(ns, '"cange.core.hl_groups" not found')
end

local found_config, config = pcall(require, "cange.config")
if found_config then
  ---Get certain config attributes
  ---@param key cange.config Path of a certain configuation key
  ---@return any Value of given key or nil if not found.
  function M.get_config(key)
    local c = config[key]
    if c == nil then
      print(ns, 'of "' .. key .. '" key is not configured!')
    end
    return c
  end
else
  print(ns, '"cange.config" not found')
end

local found_greetings, greetings = pcall(require, "cange.core.greetings")
if found_greetings then
  M.get_random_greeting_for = greetings.random_with_name
else
  print(ns, '"cange.core.greetings" not found')
end

return M
