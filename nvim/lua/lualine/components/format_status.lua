local ok, conform = pcall(require, "conform")
if not ok then
  error('[lualine.components.format_status] "conform" not found')
  return
end

local M = require("lualine.component"):extend()
local cache = {}
local before_ft = ""
local count = 0
local i = Cange.get_icon
local icons = {
  ["active"] = i("ui.CheckAll"),
  ["inactive"] = i("ui.EyeClosed"),
}
---@class Config
local config = { exclude_filetypes = { "help" } }

---@param opts Config
function M:init(opts)
  M.super.init(self, opts)
  config.exclude_filetypes =
    vim.tbl_extend("force", self.options.disabled_filetypes.statusline, opts.exclude_filetypes or {})
end

---@return table
local function get_active_formatters()
  if not ok then return {} end
  local list = {}
  for _, f in ipairs(conform.list_formatters(vim.api.nvim_get_current_buf())) do
    table.insert(list, f.name)
    count = count + 1
  end
  return list
end

---@param data table
---@return string
local function content_formatter(data)
  local state = Cange.get_config("lsp.format_on_save") and "active" or "inactive"
  local output = vim.o.columns > 100 and #data > 0 and table.concat(data or {}, ", ") or "Format"
  if vim.tbl_contains(config.exclude_filetypes, vim.bo.filetype) then return "" end
  -- PF("Formatter status -c: %s -s: %q -o: %q -bft: %q", count, state, output, before_ft)
  return string.format("%s %s", icons[state], output)
end

function M:update_status()
  return require("lualine.util").cached_status(cache, before_ft, content_formatter, get_active_formatters)
end

return M
