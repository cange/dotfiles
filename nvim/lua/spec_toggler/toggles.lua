local ns = "spec_toggler"
if not rawget(vim, "treesitter") then
  Log:warn("not treesitter", { title = ns })
  return nil
end

-- setup
local debug = false
local count = 0
local ts = vim.treesitter

---@alias SpecTogglerCommand
---| '"skip"'

local M = {
  ---@type SpecTogglerCommand
  command = "skip",
}
---@param title string
---@param args any
local function log(title, args)
  if not debug then return end
  vim.print(title, vim.inspect(args or {}))
end

local nname = function(node) return ts.get_node_text(node, 0) end

---@param node TSNode
---@param keywords table
---@return boolean
local function is_target(node, keywords)
  if node == nil then return false end
  local name = nname(node)
  if node:type() == "identifier" and vim.tbl_contains(keywords, name) then
    log("is_target MATCH", { node:type(), name = name })
    return true
  end
  return false
end

---@param node TSNode
---@param keywords table
---@return TSNode|nil
local function tree_walker(node, keywords)
  if node == nil then
    return nil
  elseif is_target(node, keywords) then
    log("walk: node -t: " .. node:type() .. " -n: " .. nname(node))
    return node
  elseif node:child_count() > 0 and is_target(node:child(), keywords) then
    log("walk: node:child() -t: " .. node:child():type() .. " -n: " .. nname(node:child()))
    return node:child()
  end
  count = count + 1
  return tree_walker(node:parent(), keywords)
end

---@param node TSNode|nil
---@example xit => it => xit|xdescribe => describe => xdescribe
function M.skip(node)
  if node == nil then
    print(ns .. ":skip() no target found!")
    return
  end
  local name = nname(node)
  local content = name:find("x") == 1 and name:sub(2) or "x" .. name
  local sr, sc, er, ec = node:range()
  log("skip: -c: " .. content .. " -n: " .. name)
  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, { content })
end

function M.toggle_skip() M["skip"](tree_walker(ts.get_node(), { "it", "describe", "xit", "xdescribe" })) end

return M
