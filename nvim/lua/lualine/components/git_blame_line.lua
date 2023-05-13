local gitsigns_found, _ = pcall(require, "gitsigns.status")
if not gitsigns_found then
  print('warn: "copilot.api" not found')
  return
end
local M = require("lualine.component"):extend()

local color = Cange.get_hl_hex("lualine_c_inactive", "fg")
local icon = Cange.get_icon("git.Commit")

Cange.set_highlights({
  -- hide actual virtual text of gitsigns
  GitSignsCurrentLineBlame = { fg = Cange.get_hl("CursorLine", { "bg" })["bg"] },
})

function M.init(self, opts) M.super.init(self, vim.tbl_extend("force", opts, { color = color })) end
function M.update_status()
  local bufnr = vim.api.nvim_get_current_buf() or 0
  local msg = vim.b[bufnr].gitsigns_blame_line or ""

  return msg == " Not Committed Yet" and icon .. msg or msg
end

return M
