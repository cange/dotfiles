local M = require("lualine.component"):extend()
local truncate = require("lualine.util").truncate
local cache = {}
local before_ft = ""
local count = 0
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.Codespace"),
  ["inactive"] = i("ui.EyeClosed"),
}

---@return table
local function get_active_clients()
  if not vim.lsp then return {} end
  local active_clients = {}
  local buf = vim.api.nvim_get_current_buf()
  vim.lsp.for_each_buffer_client(buf, function(client)
    local blacklisted = vim.tbl_contains({ "null-ls", "copilot" }, client.name)
    if client.attached_buffers[buf] and not blacklisted then table.insert(active_clients, client.name) end
    count = count + 1
  end)
  return active_clients
end

---@param data table
---@return string
local function formatter(data)
  local state = data ~= nil and #data == 0 and "inactive" or "active"
  local store = {}
  for _, label in ipairs(data) do
    table.insert(store, truncate(label, 8))
  end
  local output = vim.o.columns > 100 and #store > 0 and table.concat(store, ", ") or ""

  -- PF("LSP status -c: %s -s: %q -o: %q", count, state, output)
  return string.format("%s %s%s", icons[state], #output > 0 and "" or "LSP ", truncate(output, 24))
end

function M:update_status() return require("lualine.util").cached_status(cache, before_ft, formatter, get_active_clients) end

return M
