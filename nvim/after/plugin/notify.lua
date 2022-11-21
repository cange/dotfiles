local ns = "[plugin/notify]"
local found, notify = pcall(require, ns)
if not found then
  return
end
local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end
local icon = utils.get_icon

notify.setup({
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

  -- Default timeout for notifications
  timeout = 175,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "Normal",

  -- Minimum width for notification windows
  minimum_width = 10,

  -- Icons for the different levels
  icons = {
    ERROR = icon("diagnostics", "Error"),
    WARN = icon("diagnostics", "Warning"),
    INFO = icon("diagnostics", "Information"),
    DEBUG = icon("ui", "Bug"),
    TRACE = icon("ui", "Pencil"),
  },
})

vim.notify = notify

local notify_filter = vim.notify

vim.notify = function(msg, ...)
  if msg:match("character_offset must be called") then
    return
  end
  if msg:match("method textDocument") then
    return
  end

  notify_filter(msg, ...)
end
