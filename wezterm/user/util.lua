M = {}
---@param hex string
---@param alpha? number [0 - 0.9, 1 - 100]
---@return string
function M.hex2rgba(hex, alpha)
  local hex_val = hex:gsub("#", "")
  local rgba = {
    r = tonumber("0x" .. hex_val:sub(1, 2)),
    g = tonumber("0x" .. hex_val:sub(3, 4)),
    b = tonumber("0x" .. hex_val:sub(5, 6)),
    a = alpha and (alpha > 1 and alpha / 100 or alpha) or 1,
  }
  return string.format("rgba(%s, %s, %s, %s)", rgba.r, rgba.g, rgba.b, rgba.a)
end

function M.is_dark()
  local w = require("wezterm")
  if w.gui then return w.gui.get_appearance():find("Dark") end
  return true
end

---@param behavior 'keep' | 'force'
---@param tbl1 table
---@param tbl2 table
---@return table
function M.tbl_extend(behavior, tbl1, tbl2)
  local merged = tbl1
  if behavior == "keep" then merged = tbl2 end
  for k, v in pairs(behavior == "keep" and tbl1 or tbl2) do
    merged[k] = v
  end
  return merged
end

return M
