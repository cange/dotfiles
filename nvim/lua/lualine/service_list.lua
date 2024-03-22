local strUtil = require("cange.utils.string")
---@class StateIcons
---@field active? string
---@field inactive? string

---@class ServiceList
---@field private before_ft string
---@field private debug string
---@field private cache table
---@field private config {exclude_filetypes:string[]}
---@field private formatter function
---@field private get_data function
---@field private log function
---@field private label string|nil
---@field private state boolean
---@field private origin {super:{init:function}}
---@field private service_icons string[]
---@field private state_icons string[]
---@field get_state function
---@field set_state function
---@field cached_status function
---@field new function
---@field update function
local M = {}
M.__index = M

--- Provides a list of services which are can be displayed by icons
---@param label string|nil
---@param service_icons string[]
---@param state_icons string[]
---@param get_data function -- callback to get the data
---@param config {exclude_filetypes:string[]}
---@param debug? boolean
---@return ServiceList
function M:new(label, service_icons, state_icons, get_data, config, debug)
  return setmetatable({
    beofre_ft = "",
    cache = {},
    config = vim.tbl_extend("force", { exclude_filetypes = {} }, config),
    count = 0,
    debug = debug,
    get_data = get_data,
    label = label,
    service_icons = service_icons,
    state = true,
    state_icons = state_icons,
  }, self)
end

---@param data table
---@return string
function M:formatter(data)
  local store = {}
  local maxLength = 12
  for _, label in ipairs(data) do
    table.insert(store, self.service_icons[label] or strUtil.truncate(label, maxLength))
  end

  local output = vim.o.columns > 100 and #store > 0 and table.concat(store, " ") or ""
  if vim.tbl_contains(self.config.exclude_filetypes or {}, vim.bo.filetype) then return "" end

  local name = self.label or self.state_icons[self:get_state()]
  output = #output == 0 and self.state_icons["inactive"] or output
  return string.format("%s %s", name, output)
end

---@param new_state boolean
function M:set_state(new_state) self.state = new_state end

---@return "active" | "inactive"
function M:get_state() return self.state and "active" or "inactive" end

---@param msg string
---@param meta any
function M:log(msg, meta)
  if self.debug then
    print(string.format("[%s] %s -msg: %s -meta: %s", self.count, self.label, msg, vim.inspect(meta):gsub("\n", " ")))
    self.count = self.count + 1
  end
end

---Provides a function to cache the result of a function
---@return string[]
function M:cached_status()
  local ft = vim.fn.expand("%:e")
  ft = ft ~= "" and ft or not self.before_ft and self.before_ft or "none"

  if self.cache[ft] then
    self:log("cached", self.cache[ft])
    return self:formatter(self.cache[ft])
  end

  local data = self.get_data()
  self:log("assigned", data)

  if #data > 0 then self.cache[ft] = data end
  self:log("refreshed", self.cache[ft])

  return self:formatter(self.cache[ft] or {})
end

return M
