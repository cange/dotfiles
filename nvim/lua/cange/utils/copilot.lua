local icon = Cange.get_icon
local M = {}

---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

M.icons = {
  [""] = "  " .. icon("ui.CopilotError"),
  ["Normal"] = "  " .. icon("ui.Copilot"),
  ["Warning"] = "  " .. icon("ui.CopilotWarning"),
  ["InProgress"] = icon("ui.Sync") .. " " .. icon("ui.Copilot"),
}

M.colors = {
  [""] = Cange.fg("lualine_c_inactive"),
  ["Normal"] = Cange.fg("lualine_c_normal"),
  ["Warning"] = Cange.fg("lualine_c_diagnostics_warn_normal"),
  ["InProgress"] = Cange.fg("lualine_c_diagnostics_info_normal"),
}

M.lualine_status = {
  function()
    ---@type copilot_status_notification_data
    local data = require("copilot.api").status.data
    local msg = data.message or ""
    return (msg and #msg > 0 and msg .. " " or "") .. M.icons[data.status] .. " "
  end,
  cond = function()
    local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
    return ok and #clients > 0
  end,
  color = function()
    ---@type copilot_status_notification_data
    local data = require("copilot.api").status.data
    return M.colors[data.status]
  end,
}

return M
