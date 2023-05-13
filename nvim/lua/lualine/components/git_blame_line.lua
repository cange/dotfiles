local gitsigns_found, _ = pcall(require, "gitsigns.status")
if not gitsigns_found then
  print('warn: "copilot.api" not found')
  return
end
local M = require("lualine.component"):extend()

local color = Cange.get_hl_hex("lualine_c_inactive", "fg")
local icon = Cange.get_icon("git.Commit")

local function shorten_by_win_width(msg)
  local len = 72
  local w = vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())

  if w < 156 and w > 128 then
    len = len / 2
  elseif w <= 128 and w > 104 then
    len = len / 3
  elseif w <= 104 then
    len = 0
  end

  local suffix = len > 0 and #msg > len and "…" or ""

  return msg:sub(1, len - #suffix) .. suffix
end

function M.init(self, opts) M.super.init(self, vim.tbl_extend("force", opts, { color = color })) end
function M.update_status()
  local msg = vim.b[vim.api.nvim_get_current_buf()].gitsigns_blame_line or ""

  return shorten_by_win_width(vim.trim(msg) == "Not Committed Yet" and icon .. msg or msg)
end

return M
