local M = require("lualine.component"):extend()
local refresh_count = 0

function M:update_status()
  if not rawget(vim, "lsp") or vim.lsp.status then return "" end

  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if not Lsp then return "" end
  refresh_count = refresh_count + 1
  local msg = Lsp.message or ""
  local percentage = Lsp.percentage or 0
  local spinner = require("cange.utils.spinner").icon(refresh_count)
  local title = Lsp.title or ""
  local content = string.format("%%<%s %s %s (%s%%%%)", spinner, title, msg, percentage)

  return ("%#St_LspProgress#" .. content) or ""
end

return M
