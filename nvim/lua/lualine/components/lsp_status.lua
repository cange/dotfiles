local M = require("lualine.component"):extend()
local SerivceList = require("lualine.service_list")

---@return table
local function get_active_services()
  if not vim.lsp then return {} end
  local active_clients = {}
  local buf = vim.api.nvim_get_current_buf()
  vim.lsp.for_each_buffer_client(buf, function(client)
    local blacklisted = vim.tbl_contains({ "copilot" }, client.name)
    if client.attached_buffers[buf] and not blacklisted then table.insert(active_clients, client.name) end
  end)

  return active_clients
end

function M:init(opts)
  local state_icons = { inactive = Cange.get_icon("ui.EyeClosed") }
  M.super.init(self, opts)
  M.service_list = SerivceList:new("LSP", Cange.get_service_icons(), state_icons, get_active_services, opts)
end

function M:update_status() return M.service_list:cached_status() end

return M
