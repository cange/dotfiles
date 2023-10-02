if not rawget(vim, "treesitter") then
  Log:warn("not treesitter", { title = "spec_toggler.toggles" })
  return nil
end

local M = {}
local util = require("spec_toggler.utils")
util.debug = false

---@example it() => it.only() => it()
function M.only()
  if not util.supported("only") then return end
  local node = util.tree_walker("only", vim.treesitter.get_node())
  if node == nil then return end
  local flag = ".only"
  local name = util.name(node)
  local active = name:match(flag) ~= nil
  local content = active and vim.split(name, flag)[1] or name .. flag

  if active then
    local _, scol, _, ecol = node:range()
    util.replace_text(node, content, { start_col = scol, end_col = ecol })
  else
    util.replace_text(node, content)
  end
end

---@example xit() => it() => xit()
function M.skip()
  if not util.supported("skip") then return end
  local node = util.tree_walker("skip", vim.treesitter.get_node())
  if node == nil then return end
  local name = util.name(node)
  local content = name:find("^x") == 1 and name:sub(2) or "x" .. name
  -- util.log("skip: -c: " .. content .. " -n: " .. name)
  util.replace_text(node, content)
end

return M
