---@enumn separators
local separators = {
  arrow_strong = { left = "", right = "" },
  arrow_subtle = { left = "", right = "" },
  pill_strong = { left = "", right = "" },
  pill_subtle = { left = "", right = "" },
  strong = { left = "⏽", right = "⏽" },
  subtle = { left = "│", right = "│" },
  none = { left = "", right = "" },
}

---@enum config
local M = {
  separators = separators,
}

return M
