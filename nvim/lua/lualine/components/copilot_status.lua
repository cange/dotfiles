---@diagnostic disable: duplicate-doc-alias
---@alias copilot_status_notification_data { status: ''|'Normal'|'InProgress'|'Warning', message: string }

---@type _, { status: { data: copilot_status_notification_data } }
local ok, api = pcall(require, "copilot.api")
if not ok then
  error('[lualine.components.copilot_status] "copilot.api" not found')
  return
end
local icos = require("cange.icons")

local M = require("lualine.component"):extend()
local refresh_count = 1

-- NOTE: function wrappers enables spinner animation
local icons = {
  [""] = function() return icos.plugin.CopilotError end,
  ["Normal"] = function() return icos.plugin.Copilot end,
  ["Warning"] = function() return icos.plugin.CopilotWarning end,
  ["InProgress"] = function() return require("cange.utils.spinner").icon(refresh_count) end,
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
  refresh_count = refresh_count + 1

  return vim.trim(icons[data.status]() .. " " .. msg)
end

return M
