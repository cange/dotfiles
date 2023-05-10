local api_found, api = pcall(require, "copilot.api")
if not api_found then
  print('warn: "copilot.api" not found')
  return
end
local M = require("lualine.component"):extend()

---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

local icons = {
  [""] = Cange.get_icon("ui.CopilotError"),
  ["Normal"] = Cange.get_icon("ui.Copilot"),
  ["Warning"] = Cange.get_icon("ui.CopilotWarning"),
  ["InProgress"] = Cange.get_icon("ui.Sync"),
}
local colors = {
  [""] = Cange.get_hl_hex("Comment", "fg"),
  ["Normal"] = Cange.get_hl_hex("Normal", "fg"),
  ["Warning"] = Cange.get_hl_hex("WarningMsg", "fg"),
  ["InProgress"] = Cange.get_hl_hex("Normal", "fg"),
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
