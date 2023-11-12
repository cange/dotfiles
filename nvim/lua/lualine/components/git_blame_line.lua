---@diagnostic disable: duplicate-doc-alias
local ok, _ = pcall(require, "gitsigns")
if not ok then
  error('[lualine.components.git_blame_line] "gitsigns" not found')
  return
end

local M = require("lualine.component"):extend()

---@enum GitBlameLineConfig
local config = {
  icon = "",
  ---@diagnostic disable-next-line: assign-type-mismatch
  color = Cange.get_hl_hex("lualine_c_inactive", "fg"),
}

function M:init(opts)
  config = vim.tbl_extend("force", config, opts)
  M.super.init(self, vim.tbl_extend("force", opts, { color = config.color }))
end

function M:update_status() return vim.b.gitsigns_blame_line or "" end

return M
