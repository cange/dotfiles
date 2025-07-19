local M = require("lualine.component"):extend()
local debug = false

---@return string[]
local function observer()
  local status = vim.g.mcphub_status or "stopped"
  if not vim.g.loaded_mcphub or status == "stopped" then return { Icon.ui.EyeClosed } end

  if vim.g.mcphub_executing or status == "starting" or status == "restarting" then
    return { require("user.utils.spinner").icon() }
  end

  return { vim.g.mcphub_servers_count or 0 }
end

function M:init(opts)
  M.super.init(self, opts)

  M.service = require("lualine.user.component"):new(Icon.ui.Broadcast, {}, {}, observer, opts, debug)
  local states = M.service.states

  function M.service:get_state()
    if not vim.g.loaded_mcphub then return states.INACTIVE end
    local status = vim.g.mcphub_status or states.INACTIVE

    if status == "ready" or status == "restarted" then
      return states.ACTIVE
    elseif status == "starting" or status == "restarting" then
      return states.INACTIVE
    end

    return status == "stopped" and states.INACTIVE or states.ERROR
  end
end

function M:update_status() return M.service:cached_status() end

return M
