local M = require("lualine.component"):extend()
local cache = {}
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.CheckAll"),
  ["inactive"] = i("ui.EyeClosed"),
}

local ok, conform = pcall(require, "conform")

---@return table
local function get_active_formatters()
  if not ok then return {} end
  local list = {}
  for _, f in ipairs(conform.list_formatters(vim.api.nvim_get_current_buf())) do
    table.insert(list, f.name)
  end
  return list
end

---@param formatters table
---@return string
local function content(formatters)
  local state = ok and Cange.get_config("lsp.format_on_save") and "active" or "inactive"
  local output = vim.o.columns > 100 and #formatters > 0 and table.concat(formatters or {}, ", ") or "Format"
  output = icons[state] .. " " .. output
  return output
end

function M:update_status()
  local ft = vim.fn.expand("%:e")
  if cache[ft] then return content(cache[ft]) end
  local formatters = get_active_formatters()
  if #formatters > 0 then cache[ft] = formatters end
  return content(cache[ft] or {})
end

return M
