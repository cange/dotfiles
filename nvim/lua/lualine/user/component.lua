local strUtil = require("user.utils.string")

local log = require("plenary.log").new({ plugin = "component" })
log.level = "debug"

---@alias StateConfig {icon: string, hl: string}
---@alias StateType 'active'|'inactive'|'minimized'|'error'
---@alias StateMap table<StateType, StateConfig>
---@alias States table<string,StateType>
---@alias ServiceIconMap table<string, string>
---@alias Config {exclude_filetypes: string[]}
---@alias Observer fun(): string[] Function that returns service data

---@class Component
---@field private count integer # Debug counter for logging
---@field private debug boolean? # Whether debug logging is enabled
---@field private formatter fun(self: Component, data: string[]):string # Provides a cached status string for the current filetype. Uses cached data when available, otherwise calls the observer function.
---@field private get_status_display fun(self: Component):string, string # Get appropriate status icon and highlight for current state
---@field private log fun(self: Component, msg: string, meta: any): nil
---@field public cache table<string, string[]> # Cache for storing results by filetype
---@field public cached_status fun(self: Component): string
---@field public config Config # Component configuration options
---@field public get_state fun(self: Component): StateType
---@field public has_state boolean # Current state of the component (active/inactive)
---@field public label string? #Optional label for the component
---@field public observer Observer
---@field public service_icons ServiceIconMap # Map of service names to their icons
---@field public set_state fun(self: Component, new_state: StateType): nil
---@field public state_map StateMap # Map of states to their configurations
---@field public states States # The available component states
local M = {}
M.__index = M

M.states = {
  ACTIVE = "active",
  ERROR = "error",
  INACTIVE = "inactive",
  MINIMIZED = "minimized",
}

---@enum StateMap
local default_states = {
  active = { icon = Icon.ui.Eye, hl = "lualine_c_normal" },
  error = { icon = Icon.ui.Error, hl = "lualine_c_diagnostics_error_normal" },
  inactive = { icon = Icon.ui.EyeClosed, hl = "lualine_c_inactive" },
  minimized = { icon = Icon.ui.Eye, hl = "lualine_c_normal" },
}

---Merge custom icon states with default state map
---@param icon_states table<string, string> Map of state names to their icons
---@return StateMap Merged state map with custom icons
---@nodiscard
local function merge_state_map(icon_states)
  local new_states = vim.deepcopy(default_states)

  for state, icon in pairs(icon_states) do
    if default_states[state] then new_states[state] = { icon = icon, hl = default_states[state].hl } end
  end

  return new_states
end

--- Provides a list of services which can be displayed by icons
---@param label string? Optional label for the component
---@param service_icons ServiceIconMap Map of service names to their icons
---@param icon_states table<string, string> Map of state names to their icons
---@param observer Observer Callback function to get the data
---@param config Config? Component configuration options
---@param debug boolean? Enable debug logging
---@return Component
function M:new(label, service_icons, icon_states, observer, config, debug)
  return setmetatable({
    cache = {},
    config = vim.tbl_extend("force", { exclude_filetypes = {} }, config),
    count = 0,
    debug = debug,
    observer = observer,
    label = label,
    service_icons = service_icons,
    state = self.states.ACTIVE,
    state_map = merge_state_map(icon_states),
  }, self)
end

function M:log(msg, meta)
  if self.debug then
    log.debug(("[%s] %s -msg: %s -meta: %s"):format(self.count, self.label, msg, vim.inspect(meta):gsub("\n", " ")))
    self.count = self.count + 1
  end
end

function M:formatter(data)
  local store = {}
  local maxLength = 12

  for _, label in ipairs(data) do
    table.insert(store, self.service_icons[label] or strUtil.truncate(tostring(label), maxLength))
  end

  local output = vim.o.columns > 100 and #store > 0 and table.concat(store, " ") or ""
  if vim.tbl_contains(self.config.exclude_filetypes or {}, vim.bo.filetype) then return "" end

  local status_icon, status_hl = self:get_status_display()
  output = #output == 0 and self.state_map.minimized.icon or output
  -- Format with highlight
  return ("%%#%s#%s%%*"):format(status_hl, status_icon .. " " .. output .. " ")
end

function M:set_state(new_state) self.state = new_state end

function M:get_state() return self.state end

function M:get_status_display()
  local state = self:get_state()
  local name_or_icon = self.label or self.state_map[state].icon

  return name_or_icon, self.state_map[state].hl
end

function M:cached_status()
  local ft = vim.fn.expand("%:e")
  local data = {}
  ---@type 'cache'|'cached'|'refresh'
  local type = nil
  ft = ft ~= "" and ft or "none"

  if self.cache[ft] then
    data = self.cache[ft]
    type = "cached"
  else
    data = self.observer()
    type = "refresh"
  end

  if type == "refresh" and #data > 0 and data[0] ~= data[0] then
    self.cache[ft] = data
    type = "cache"
  end

  if type then self:log(type, data) end

  return self:formatter(data or {})
end

return M
