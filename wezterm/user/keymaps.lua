local wezterm = require("wezterm")
local act = wezterm.action

local function desc(text)
  return wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { AnsiColor = "Fuchsia" } },
    { Text = text },
  })
end

return {
  -- sessions
  { key = "s", mods = "LEADER", action = act.EmitEvent("save_session") },
  { key = "r", mods = "LEADER", action = act.EmitEvent("restore_session") },
  -- Pane splitting
  { key = "d", mods = "SUPER", action = act.SplitHorizontal },
  { key = "d", mods = "SUPER|SHIFT", action = act.SplitVertical },
  { key = "-", mods = "LEADER", action = act.SplitVertical },
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal },
  { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
  -- Pane sizes
  { key = "Enter", mods = "SUPER", action = act.ToggleFullScreen },
  { key = "Enter", mods = "SUPER|SHIFT", action = act.TogglePaneZoomState },
  -- Pane sizing
  { key = "LeftArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Left", 3 }) },
  { key = "RightArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Right", 3 }) },
  { key = "UpArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Up", 3 }) },
  { key = "DownArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Down", 3 }) },
  -- Pane rotation
  { key = "[", mods = "SUPER|SHIFT", action = act.RotatePanes("CounterClockwise") },
  { key = "]", mods = "SUPER|SHIFT", action = act.RotatePanes("Clockwise") },
  -- Pane switching
  { key = "LeftArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "SUPER|SHIFT", action = act.ActivatePaneDirection("Down") },
  -- Tap navigation
  { key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
  -- Word jumping
  { key = "LeftArrow", mods = "SUPER", action = act.SendString("\x1bb") },
  { key = "RightArrow", mods = "SUPER", action = act.SendString("\x1bf") },

  { -- open wezterm settings in new tab
    key = ",",
    mods = "SUPER",
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir, args = { "nvim", wezterm.config_file } }),
  },

  { -- Tab renaming
    key = "t",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = desc("Rename tab:"),
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },
}
