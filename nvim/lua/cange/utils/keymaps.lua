--#region Types

---@class cange.keymapsMapping
---@field [1] string lhs/key command of the keybinding
---@field [2] string|function command of the keybinding
---@field [3] string Description of the keybinding
---@field mode? string|table Mode short-name ("n", "i", "v", "x", …)

---@class cange.keymapsMappingGroup
---@field mappings table<cange.keymapsMapping[]> The actual key bindings
---@field leader string Key or key group to trigger the certain mapping group
---@field name string Is displayed as group name

--#endregion

---@param group cange.keymapsMappingGroup
---@return table<string, table> # WhichKey mappings
local function define_mappings_of(group)
  local section = {}
  section[group.leader] = { name = group.name }
  local mappings = section[group.leader]

  for _, mapping in pairs(group.mappings) do
    local keymap = vim.deepcopy(mapping)
    local key = table.remove(keymap, 1)
    mappings[key] = keymap
  end

  return section
end

local M = {}

---@return cange.keymapsMappingGroup[]
function M.whichkey_mappings()
  local mappings = {}
  local groups = require("cange.keymaps").groups

  for _, group in pairs(groups) do
    mappings = vim.tbl_extend("keep", mappings, define_mappings_of(group))
  end

  return mappings
end

return M
