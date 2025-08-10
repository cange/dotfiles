local ns = "[user.utils]"

local M = {}

M.get_service_icons = require("user.utils.icons").get_service_icons

---Get certain config attributes
---@param key_path string Dot separated path of config group
---@return table|any value of given key or nil if not found.
function M.get_config(key_path)
  local prop = require("user.config")

  for _, key in pairs(vim.split(key_path, "%.")) do
    local next_prop = prop[key]
    if next_prop ~= nil then
      ---@diagnostic disable-next-line: cast-local-type
      prop = next_prop
    end
  end

  return prop
end

---Assigns the given value to the global config table
---@param key string
---@param value any
---@return any # Either registered or the value of taken key
function M.set_config(key, value)
  local config = require("user.config")

  local parts = {}
  for part in string.gmatch(key, "[%w_]+") do
    table.insert(parts, part)
  end

  local last_key = table.remove(parts)

  for _, part in ipairs(parts) do
    if config[part] == nil then
      config[part] = {}
    elseif type(config[part]) ~= "table" then
      print(ns, "set_config", "Cannot set subkey of non-table value")
    end
    config = config[part]
  end

  config[last_key] = value

  return config[last_key]
end

---Reruns a module file by removing the given module first
---@param module_name string
---@return table|any
function M.reload(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

---@param highlights table<string, table>
---@see vim.api.nvim_set_hl
function M.set_highlights(highlights)
  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

---Returns the hex value of the given highlight group
---@param name string # Normal, Comment, etc.
---@param key string # fg, bg, etc.
---@return table|nil
---@example get_hl_hex("Normal", "fg") --> {fg = "#123456"}
function M.get_hl_hex(name, key)
  local hl = User.get_hl(name, { key })
  local value = hl[key] or nil
  local output = {}

  if not value then
    value = 0
    PF("%s %q in %q hl group not found -inspect %q -value %q", ns, key, name, vim.inspect(hl), value)
  end

  output[key] = ("#%06x"):format(value)
  return output
end

---Returns actual values of the given highlight group name and allows to filter
---@param name string
---@param keywords? table
---@return {fg?:number, bg?:number, bold?:boolean, italic?:boolean}
---@example get_hl("Normal", {"fg", "bg"}) --> {fg = 123, bg = 456}
function M.get_hl(name, keywords)
  keywords = keywords or nil
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if not hl then P("%s hl %q not found -inspect %q", ns, name, vim.inspect(hl)) end
  if not keywords then return hl end
  local output = {}
  for _, k in pairs(keywords) do
    if hl[k] then output[k] = hl[k] end
  end

  return output
end

---allows to set a width depending columns on the window
---@param breakpoint integer
---@param down number width when columns lower than breakpoint
---@param up number width when columns higher than breakpoint
---@return integer
function M.responsive_width(breakpoint, down, up) return vim.o.columns > breakpoint and up or down end

return M
