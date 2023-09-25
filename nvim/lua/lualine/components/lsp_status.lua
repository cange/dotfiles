local M = require("lualine.component"):extend()
local refresh_count = 0
local cache = {}
local debug = false
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.Eye"),
  ["inactive"] = i("ui.EyeClosed"),
}

local function get_active_clients()
  local active_clients = {}
  local buf = vim.api.nvim_get_current_buf()
  vim.lsp.for_each_buffer_client(buf, function(client)
    local blacklisted = vim.tbl_contains({ "null-ls", "copilot" }, client.name)
    if client.attached_buffers[buf] and not blacklisted then table.insert(active_clients, client.name) end
    refresh_count = refresh_count + 1
  end)
  return active_clients
end

---@param clients table
---@param debug_label string
---@return string
local function content(clients, debug_label)
  local state = clients ~= nil and #clients == 0 and "inactive" or "active"
  local output = vim.o.columns > 100 and #clients > 0 and ": " .. table.concat(clients, ", ") or ""
  output = icons[state] .. " LSP" .. output
  if debug then vim.print("lsp " .. debug_label .. " -c: " .. refresh_count .. " -output: " .. output) end
  return output
end

function M:update_status()
  if not vim.lsp then return content({}, "lsp not supported") end
  local ft = vim.fn.expand("%:e")
  if cache[ft] then return content(cache[ft], "cache") end
  local active_clients = get_active_clients()
  if #active_clients > 0 then cache[ft] = active_clients end
  return content(cache[ft] or {}, "fallback")
end

return M
