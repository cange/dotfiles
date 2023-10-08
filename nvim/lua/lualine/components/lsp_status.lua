local M = require("lualine.component"):extend()
local cache = {}
-- local count = 0
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.Eye"),
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
    -- count = count + 1
  end)
  return active_clients
end

---@param data table
---@return string
local function content(data)
  local state = data ~= nil and #data == 0 and "inactive" or "active"
  local output = vim.o.columns > 100 and #data > 0 and table.concat(data, ", ") or ""
  -- P("LSP status -c: " .. count .. " -s: " .. state .. " -o: " .. output)
  return string.format("%s Lsp %s", icons[state], output)
end

function M:update_status()
  local ft = vim.fn.expand("%:e")
  if cache[ft] then return content(cache[ft]) end
  local active_clients = get_active_clients()
  if #active_clients > 0 then cache[ft] = active_clients end
  return content(cache[ft] or {})
end

return M
