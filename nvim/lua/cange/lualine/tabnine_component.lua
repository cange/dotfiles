local ns = "[cange.lualine.tabnine_component]"
local ok, tabnine = pcall(require, "tabnine")
if not ok then
  print(ns, '"tabnine" not found')
  return
end

local M = require("lualine.component"):extend()

function M.init(self, options)
  M.super.init(self, options)
end

local prefix = Cange.get_icon("ui.Tabnine", { trim = true })
local service_level = nil
local count = 1
local service_levels = { "business", "free", "pro", "trial" }
local progress_icons = vim.split("⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏", " ")

function M.update_status()
  if not vim.tbl_contains(service_levels, service_level) then
    service_level = tabnine.service_level()

    if not service_level then
      service_level = progress_icons[1 + (count % #progress_icons)]
    end

    service_level = service_level:lower()
    count = count + 1
  end

  return prefix .. " " .. service_level
end

return M
