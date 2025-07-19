local ok, conform = pcall(require, "conform")
if not ok then error('[lualine.components.format_status] "conform" not found') end

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
  local state_icons = { active = Icon.ui.CheckAll }
  M.super.init(self, opts)
  M.service =
    require("lualine.user.component"):new(nil, User.get_service_icons(), state_icons, get_active_services, opts, debug)
end

function M:update_status()
  local states = M.service.states
  M.service:set_state(User.get_config("lsp.format_on_save") and states.ACTIVE or states.INACTIVE)
  return M.service:cached_status()
end

return M
