local M = require("lualine.component"):extend()
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.Eye"),
  ["inactive"] = i("ui.EyeClosed"),
}

function M:update_status()
  local state = Cange.get_config("lsp.format_on_save") and "active" or "inactive"
  return icons[state] .. " Format"
end

return M
