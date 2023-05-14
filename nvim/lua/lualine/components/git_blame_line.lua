local gitsigns_found, _ = pcall(require, "gitsigns")
if not gitsigns_found then
  print('warn: "gitsigns" not found')
  return
end

local M = require("lualine.component"):extend()

---@alias GitBlameLineConfig {icon: string,color: string, ignore_filetypes: string[]}
---@alias GitBlameLineCache {win_count: integer, total_width: integer}
--
---@type GitBlameLineConfig
local config = {
  ---@diagnostic disable: assign-type-mismatch
  icon = "",
  color = Cange.get_hl_hex("lualine_c_inactive", "fg"),
  ---@diagnostic enable: assign-type-mismatch
  ignore_filetypes = {
    "telescopeprompt",
    "telescoperesults",
    "telescopepreviewer",
    "cmp_menu",
    "notify",
    "fidget",
    "whichkey",
    "harpoon",
  },
}

---@type GitBlameLineCache
local cache = {
  win_count = 0,
  total_width = 0,
}

---Determine total width of all windows
---@return integer|string[]
local function get_total_width()
  local wins = vim.api.nvim_list_wins()
  if cache.win_count == #wins then return cache.total_width end

  local total_width = 0
  for _, winid in ipairs(wins) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    if not vim.tbl_contains(config.ignore_filetypes, filetype:lower()) then
      local width = vim.api.nvim_win_get_width(winid)
      total_width = total_width + width
    end
  end

  cache.total_width = total_width
  cache.win_count = #wins

  return total_width
end

---@param msg string
---@return string
local function shorten_by_win_width(msg)
  local len = 72
  local w = get_total_width()

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

function M.init(self, opts)
  config = vim.tbl_extend("force", config, opts)
  M.super.init(self, vim.tbl_extend("force", opts, { color = config.color }))
end
function M.update_status()
  local msg = vim.b[vim.api.nvim_get_current_buf()].gitsigns_blame_line or ""
  return shorten_by_win_width(vim.trim(msg))
end

return M
