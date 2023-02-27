local ns = "[cange.utils.whichkey]"

---@param group_id string|nil
---@return Cange.core.WhichKey.group[] # All defined groups or one when group_id is specified
local function get_group(group_id)
  local ok, groups = pcall(require, "cange.core.whichkey")
  if not ok then
    print(ns, '"cange.core.whichkey" not found!')
  end
  return group_id == nil and groups[group_id] or groups
end

---@param group Cange.core.WhichKey.group
---@return table<string, table> # WhichKey mappings
local function get_mappings_by_group(group)
  local section = {}
  section[group.subleader] = { name = group.title }

  local section_mappings = section[group.subleader]

  for key, mapping in pairs(group.mappings) do
    -- Ignore primary keys
    if mapping.primary then
      goto skip
    end
    section_mappings[key] = { mapping.cmd, mapping.desc }
    ::skip::
  end

  return section
end

---@param group Cange.core.WhichKey.group Key of a keybinding block
---@param target_mappings table List to store mappings
local function fetch_primary_key_mappings(group, target_mappings)
  -- vim.pretty_print(ns, 'primary_mappings', vim.tbl_keys(group))
  for key, mapping in pairs(group.mappings) do
    -- vim.pretty_print(ns, 'primary_mappings', m.desc, m.primary)
    -- Primary keys only
    if not mapping.primary then
      goto skip
    end
    target_mappings[key] = { mapping.cmd, mapping.desc }
    ::skip::
  end
end

---@type Cange.core.WhichKey
local m = {}

---@return Cange.core.WhichKey.group[]
function m.mappings()
  local primary = {}
  local secondary = {}

  for _, g in pairs(get_group()) do
    secondary = vim.tbl_extend("keep", secondary, get_mappings_by_group(g))
    fetch_primary_key_mappings(g, primary)
  end

  return vim.tbl_deep_extend("keep", primary, secondary)
end

return m
