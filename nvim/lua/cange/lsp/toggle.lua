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
  local state = toggle(Cange.get_config("lsp.diagnostic_virtual_text"), "Diagnostic virtual inline text")
  Cange.set_config("lsp.diagnostic_virtual_text", state)
  require("cange.lsp").update_diagnostics()
end

function M.format_on_save()
  local state = toggle(Cange.get_config("lsp.format_on_save"), "Auto format on save")
  Cange.set_config("lsp.format_on_save", state)
  require("cange.lsp").update_format_on_save()
end

return M
