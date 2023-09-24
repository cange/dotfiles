---@diagnostic disable: duplicate-doc-alias
local ok, _ = pcall(require, "gitsigns")
if not ok then
  print('warn: "gitsigns" not found')
  return
end

local M = require("lualine.component"):extend()

---@enum GitBlameLineConfig
local config = {
  icon = "",
  ---@diagnostic disable-next-line: assign-type-mismatch
  color = Cange.get_hl_hex("lualine_c_inactive", "fg"),
}

---@param msg string
---@return string
local function shorten_by_win_width(msg)
  local len = 72
  local w = vim.o.columns

  if w < 156 and w > 128 then
    len = len / 2
  elseif w <= 128 and w > 104 then
    len = len / 3
  elseif w <= 104 then
    len = 0
  end

  local suffix = len > 0 and #msg > len and "…" or ""

  return vim.trim(msg):sub(1, len - #suffix) .. suffix
end

function M.init(self, opts)
  config = vim.tbl_extend("force", config, opts)
  M.super.init(self, vim.tbl_extend("force", opts, { color = config.color }))
end
function M.update_status()
  local msg = vim.b.gitsigns_blame_line or ""

  return shorten_by_win_width(msg)
end

return M
