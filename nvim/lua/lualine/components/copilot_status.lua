---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

---@type _, { status: { data: copilot_status_notification_data } }
local api_found, api = pcall(require, "copilot.api")
if not api_found then
  print('warn: "copilot.api" not found')
  return
end
local M = require("lualine.component"):extend()

local icons = {
  [""] = Cange.get_icon("ui.CopilotError"),
  ["Normal"] = Cange.get_icon("ui.Copilot"),
  ["Warning"] = Cange.get_icon("ui.CopilotWarning"),
  ["InProgress"] = Cange.get_icon("ui.Sync"),
}
local colors = {
  [""] = Cange.get_hl_hex("lualine_c_inactive", "fg"),
  ["Normal"] = Cange.get_hl_hex("lualine_c_normal", "fg"),
  ["Warning"] = Cange.get_hl_hex("WarningMsg", "fg"), -- using `WarningMsg` avoid missing hl issue
  ["InProgress"] = Cange.get_hl_hex("lualine_c_normal", "fg"),
}

function M.init(self, opts)
  M.super.init(
    self,
    vim.tbl_extend("force", opts, {
      color = function()
        local data = api.status.data

        return colors[data.status]
      end,
    })
  )
end

function M.update_status()
  local data = api.status.data
  local msg = data.message or ""

  msg = (msg and #msg > 0 and msg .. " " or "")

  return icons[data.status] .. " " .. msg
end

return M
