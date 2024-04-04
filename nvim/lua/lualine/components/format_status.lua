local ok, conform = pcall(require, "conform")
if not ok then
  error('[lualine.components.format_status] "conform" not found')
  return
end

local M = require("lualine.component"):extend()
local debug = false

---@return table
local function get_active_services()
  if not ok then return {} end
  local list = {}
  for _, f in ipairs(conform.list_formatters(vim.api.nvim_get_current_buf())) do
    table.insert(list, f.name)
  end
  return list
end

function M:init(opts)
  local state_icons = {
    active = Cange.get_icon("ui.CheckAll"),
    inactive = Cange.get_icon("ui.EyeClosed"),
  }
  M.super.init(self, opts)
  M.list_services = require("lualine.list_services"):new(nil, {}, state_icons, get_active_services, opts, debug)
end

function M:update_status()
  M.list_services:set_state(Cange.get_config("lsp.format_on_save"))
  return M.list_services:cached_status()
end

return M
