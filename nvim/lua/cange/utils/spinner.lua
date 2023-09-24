---@diagnostic disable-next-line: param-type-mismatch
local icons = vim.split(Cange.get_icon("sets.circles"), " ")
local icon_len = #icons

local M = {}

---Retruns an individual spinner icon depending on the frame.
---@param count? number|nil
---@return string
function M.icon(count)
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(count or ms / 120) % icon_len

  return icons[frame + 1]
end

return M
