local format_on_save = Cange.get_config("lsp.format_on_save")
local diagnostic_virtual_text = Cange.get_config("lsp.diagnostic_virtual_text")

---Toggles given state, returns it and logs the change.
---@param state boolean
---@param title string
---@return boolean
local function toggle(state, title)
  state = not state
  local msg = state and "enabled" or "disabled"
  Log:info(msg, title)
  return state
end

local M = {}

function M.virtual_text()
  local toggle_state = toggle(diagnostic_virtual_text, "Diagnostic virtual inline text")
  Cange.set_config("lsp.diagnostic_virtual_text", toggle_state)
  require("cange.lsp").update_diagnostics()
end

function M.format_on_save()
  local toggle_state = toggle(format_on_save, "Auto format on save")
  Cange.set_config("lsp.format_on_save", toggle_state)
  require("cange.lsp").update_format_on_save()
end

return M
