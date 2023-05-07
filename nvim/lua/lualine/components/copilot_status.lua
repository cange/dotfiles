local api_found, api = pcall(require, "copilot.api")
if not api_found then
  print('warn: "copilot.api" not found')
  return
end
local icon = Cange.get_icon
local M = require("lualine.component"):extend()

---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

local icons = {
  [""] = icon("ui.CopilotError"),
  ["Normal"] = icon("ui.Copilot"),
  ["Warning"] = icon("ui.CopilotWarning"),
  ["InProgress"] = icon("ui.Sync"),
}
local colors = {
  [""] = Cange.fg("lualine_c_inactive"),
  ["Normal"] = Cange.fg("lualine_c_normal"),
  ["Warning"] = Cange.fg("lualine_c_diagnostics_warn_normal"),
  ["InProgress"] = Cange.fg("lualine_c_normal"),
}

function M.init(self, opts)
  M.super.init(
    self,
    vim.tbl_extend("force", opts, {
      color = function()
        ---@type copilot_status_notification_data
        local data = api.status.data

        return colors[data.status]
      end,
    })
  )
end

function M.update_status()
  ---@type copilot_status_notification_data
  local data = api.status.data
  local msg = data.message or ""

  msg = (msg and #msg > 0 and msg .. " " or "")

  return icons[data.status] .. " " .. msg
end

return M
