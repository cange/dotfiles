local M = require("lualine.component"):extend()
local ServiceList = require("lualine.service_list")

function M:init(opts)
  local state_icons = { inactive = Cange.get_icon("ui.EyeClosed") }
  M.super.init(self, opts)
  M.serivce_list = ServiceList:new("Lint", Cange.get_service_icons(), state_icons, require("lint").get_running, opts)
end

function M:update_status() return M.serivce_list:cached_status() end

return M
