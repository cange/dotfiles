--#region Types

---@class cange.keymapsMapping
---@field [1] string lhs/key command of the keybinding
---@field [2] string|function command of the keybinding
---@field desc string Description of the keybinding
---@field mode? string|table Mode short-name ("n", "i", "v", "x", …)

---@class cange.keymapsMappingGroup
---@field mappings table<cange.keymapsMapping[]> The actual key bindings
---@field leader string Key or key group to trigger the certain mapping group
---@field name string Is displayed as group name

--#endregion

---@param keymap cange.keymapsMapping
---@param group_mappings table
local function assign_to_group(keymap, group_mappings)
  local key = keymap[1]
  local cmd = keymap[2]
  local mapping = { cmd, keymap.desc, keymap.mode }
  if keymap.mode then
    mapping = vim.tbl_extend("keep", mapping, { mode = keymap.mode })
  end
  group_mappings[key] = mapping
end

---@param group cange.keymapsMappingGroup
---@return table<string, table> # WhichKey mappings
local function get_mappings_by_group(group)
  local section = {}
  section[group.leader] = { name = group.name }
  local mappings = section[group.leader]

  for _, keymap in pairs(group.mappings) do
    assign_to_group(keymap, mappings)
  end

  return section
end

local M = {}

---@return cange.keymapsMappingGroup[]
function M.mappings()
  local mappings = {}
  local groups = require("cange.keymaps").groups

  for _, group in pairs(groups) do
    mappings = vim.tbl_extend("keep", mappings, get_mappings_by_group(group))
  end

  return mappings
end

return M
