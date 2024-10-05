---Toggles given state, returns it and logs the change.
---@param state boolean
---@param title string
---@return boolean
local function toggle(state, title)
  local new_state = not state
  local msg = new_state and "enabled" or "disabled"
  Log:info(msg, title)
  return new_state
end

local M = {}

function M.virtual_text()
  local state = toggle(User.get_config("lsp.diagnostic_virtual_text"), "Diagnostic virtual inline text")
  User.set_config("lsp.diagnostic_virtual_text", state)
  require("user.lsp").update_diagnostics()
end

function M.format_on_save()
  local state = toggle(User.get_config("lsp.format_on_save"), "Auto format on save")
  User.set_config("lsp.format_on_save", state)
  require("user.lsp").update_format_on_save()
end

return M
