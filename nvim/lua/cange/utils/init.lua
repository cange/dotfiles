local ns = "cange.utils.init"
local found_greetings, greetings = pcall(require, "cange.utils.greetings")
if not found_greetings then
  print("[" .. ns .. '] "cange.utils.greetings" not found')
  return
end
local found_icons, icons = pcall(require, "cange.utils.icons")
if not found_icons then
  print("[" .. ns .. '] "cange.utils.icons" not found')
  return
end
---@module 'utils'

---Provides keymap convenience helpers
local M = {}

---@see vim.keymap.set()
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

---Set highlight group by given table.
---@param highlights table<string,table>
---@see vim.api.nvim_set_hl
function M.set_hls(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

M.greetings = greetings
M.icons = icons

---Ensures that the icons of given parts exists
---@param ... string List of parts the actual icon path
---@return string|table|nil The icon symbol or nil if not found
function M.get_icon(...)
  local icon = icons
  local parts = { ... }
  local function get_icon(name)
    return icon[name]
  end

  for _, name in ipairs(parts) do
    local found_icon, _icon = pcall(get_icon, name)
    if not found_icon then
      vim.pretty_print("[" .. ns .. "] icon for " .. vim.inspect(parts) .. " not found")
      return nil
    end

    icon = _icon
  end

  -- vim.pretty_print("icon", icon)
  return icon
end

return M
