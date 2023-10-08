local ok, conform = pcall(require, "conform")
local M = require("lualine.component"):extend()
local cache = {}
-- local count = 0
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.CheckAll"),
  ["inactive"] = i("ui.EyeClosed"),
}

---@return table
local function get_active_formatters()
  if not ok then return {} end
  local list = {}
  for _, f in ipairs(conform.list_formatters(vim.api.nvim_get_current_buf())) do
    table.insert(list, f.name)
    -- count = count + 1
  end
  return list
end

---@param data table
---@return string
local function content(data)
  local state = ok and Cange.get_config("lsp.format_on_save") and "active" or "inactive"
  local output = vim.o.columns > 100 and #data > 0 and table.concat(data or {}, ", ") or "Format"
  -- P("Format status -c: " .. count .. " -s: " .. state .. " -o: " .. output)
  return string.format("%s %s", icons[state], output)
end

function M:update_status()
  local ft = vim.fn.expand("%:e")
  if cache[ft] then return content(cache[ft]) end
  local formatters = get_active_formatters()
  if #formatters > 0 then cache[ft] = formatters end
  return content(cache[ft] or {})
end

return M
