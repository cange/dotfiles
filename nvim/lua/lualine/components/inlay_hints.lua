local M = require("lualine.component"):extend()

local config = {
  exclude_filetypes = {},
  icon = Icon.ui.Eye,
}

---@return boolean
local function is_active()
  if not vim.lsp then return false end
  if vim.tbl_contains(config.exclude_filetypes, vim.bo.filetype) then return false end
  return vim.lsp.inlay_hint.is_enabled({ 0 })
end

function M:init(opts)
  config = vim.tbl_extend("force", config, opts)
  M.super.init(self, config)
end

function M.update_status()
  if not is_active() then return "" end
  return "Inlay Hints"
end

return M
