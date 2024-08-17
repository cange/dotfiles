local wezterm = require("wezterm")
local action = wezterm.action

return {
  -- Pane splitting
  { key = "d", mods = "SUPER|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "SUPER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "SUPER|SHIFT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "SUPER|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "k", mods = "SUPER", action = action.ClearScrollback("ScrollbackAndViewport") },
  { key = "LeftArrow", mods = "SUPER", action = action.ClearScrollback("ScrollbackAndViewport") },
  -- Pane sizes
  { key = "Enter", mods = "SUPER", action = action.ToggleFullScreen },
  { key = "Enter", mods = "SUPER|SHIFT", action = action.TogglePaneZoomState },
  -- Pane sizing
  { key = "LeftArrow", mods = "SUPER|CTRL", action = action.AdjustPaneSize({ "Left", 3 }) },
  { key = "RightArrow", mods = "SUPER|CTRL", action = action.AdjustPaneSize({ "Right", 3 }) },
  { key = "UpArrow", mods = "SUPER|CTRL", action = action.AdjustPaneSize({ "Up", 3 }) },
  { key = "DownArrow", mods = "SUPER|CTRL", action = action.AdjustPaneSize({ "Down", 3 }) },
  -- Pane rotation
  { key = "[", mods = "SUPER|SHIFT", action = action.RotatePanes("CounterClockwise") },
  { key = "]", mods = "SUPER|SHIFT", action = action.RotatePanes("Clockwise") },
  -- Pane switching
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Down") },
  -- Tap navigation
  { key = "[", mods = "SUPER", action = action.ActivateTabRelative(-1) },
  { key = "]", mods = "SUPER", action = action.ActivateTabRelative(1) },
  -- Word jumping
  { key = "LeftArrow", mods = "SUPER", action = action.SendString("\x1bb") },
  { key = "RightArrow", mods = "SUPER", action = action.SendString("\x1bf") },
  -- open wezterm settings in new tab
  {
    key = ",",
    mods = "SUPER",
    action = action.SpawnCommandInNewTab({ cwd = wezterm.home_dir, args = { "nvim", wezterm.config_file } }),
  },
}
