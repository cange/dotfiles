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
local found_config, config = pcall(require, "cange.config")
if not found_config then
  print("[" .. ns .. '] "cange.config" not found')
  return
end
---@module 'cange.utils'

---Provides keymap convenience helpers
local M = {}

---Keymap with preconfigured noremap
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts? table
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
M.get_icon = icons.get_icon
M.get_config = config.get_config

return M
