-- local ns = "[after/plugin/notify]"
local found, notify = pcall(require, "notify")
if not found then
  return
end

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
    ERROR = Cange.get_icon("diagnostics.Error"),
    WARN = Cange.get_icon("diagnostics.Warning"),
    INFO = Cange.get_icon("diagnostics.Information"),
    DEBUG = Cange.get_icon("ui.Bug"),
    TRACE = Cange.get_icon("ui.Pencil"),
  },
})

vim.notify = function(msg, ...)
  if msg:match("character_offset must be called") then
    return
  end
  if msg:match("method textDocument") then
    return
  end

  notify(msg, ...)
end
