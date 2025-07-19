local M = require("lualine.component"):extend()
local debug = false

---@return table
local function get_active_services()
  if not vim.lsp then return {} end
  local active_clients = {}
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local blacklisted = vim.tbl_contains({ "copilot" }, client.name)
    if client.attached_buffers[bufnr] and not blacklisted then table.insert(active_clients, client.name) end
  end
  return active_clients
end

function M:init(opts)
  M.super.init(self, opts)
  M.service = require("lualine.user.component"):new(
    Icon.ui.Server,
    User.get_service_icons(),
    {},
    get_active_services,
    opts,
    debug
  )
end

function M:update_status() return M.service:cached_status() end

return M
