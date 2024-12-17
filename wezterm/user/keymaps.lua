local wezterm = require("wezterm")
local a = wezterm.action

local function desc(text)
  return wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { AnsiColor = "Fuchsia" } },
    { Text = text },
  })
end

return {
  { key = "l", mods = "LEADER", action = a.ShowDebugOverlay },
  -- sessions
  { key = "s", mods = "LEADER", action = a.EmitEvent("save_session") },
  { key = "r", mods = "LEADER", action = a.EmitEvent("restore_session") },
  -- Pane splitting
  { key = "d", mods = "CMD", action = a.SplitHorizontal },
  { key = "d", mods = "CMD|SHIFT", action = a.SplitVertical },
  { key = "-", mods = "LEADER", action = a.SplitVertical },
  { key = "\\", mods = "LEADER", action = a.SplitHorizontal },
  { key = "k", mods = "CMD", action = a.ClearScrollback("ScrollbackAndViewport") },
  -- Pane sizes
  { key = "Enter", mods = "CMD", action = a.ToggleFullScreen },
  { key = "Enter", mods = "CMD|SHIFT", action = a.TogglePaneZoomState },
  -- Pane sizing
  { key = "LeftArrow", mods = "CMD|CTRL", action = a.AdjustPaneSize({ "Left", 3 }) },
  { key = "RightArrow", mods = "CMD|CTRL", action = a.AdjustPaneSize({ "Right", 3 }) },
  { key = "UpArrow", mods = "CMD|CTRL", action = a.AdjustPaneSize({ "Up", 3 }) },
  { key = "DownArrow", mods = "CMD|CTRL", action = a.AdjustPaneSize({ "Down", 3 }) },
  -- Pane rotation
  { key = "[", mods = "CMD|SHIFT", action = a.RotatePanes("CounterClockwise") },
  { key = "]", mods = "CMD|SHIFT", action = a.RotatePanes("Clockwise") },
  -- Pane switching
  { key = "LeftArrow", mods = "CMD|SHIFT", action = a.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CMD|SHIFT", action = a.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "CMD|SHIFT", action = a.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "CMD|SHIFT", action = a.ActivatePaneDirection("Down") },
  -- Tap navigation
  { key = "[", mods = "CMD", action = a.ActivateTabRelative(-1) },
  { key = "]", mods = "CMD", action = a.ActivateTabRelative(1) },
  -- Word jumping
  { key = "LeftArrow", mods = "CMD", action = a.SendString("\x1bb") },
  { key = "RightArrow", mods = "CMD", action = a.SendString("\x1bf") },

  { -- open wezterm settings in new tab
    key = ",",
    mods = "CMD",
    action = a.SpawnCommandInNewTab({ cwd = wezterm.home_dir, args = { "nvim", wezterm.config_file } }),
  },

  { -- Tab renaming
    key = "t",
    mods = "LEADER",
    action = a.PromptInputLine({
      description = desc("Rename tab:"),
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },
}
