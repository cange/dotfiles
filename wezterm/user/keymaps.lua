local wezterm = require("wezterm")
local act = wezterm.action

-- https://github.com/danielcopper/wezterm-session-manager
local ok, session_manager = pcall(require, "wezterm-session-manager/session-manager")
if not ok then
  error("[wezterm-session-manager] not found! Ensure wezterm-session-manager repo is cloned to your runtimepath")
  -- run git clone https://github.com/danielcopper/wezterm-session-manager.git ~/.config/wezterm/wezterm-session-manager
end

wezterm.on("save_session", function(win)
  wezterm.log_info("Save session!", win)
  session_manager.save_state(win)
end)
wezterm.on("restore_session", function(win)
  wezterm.log_info("Restore session!", win)
  session_manager.restore_state(win)
end)

local function desc(text)
  wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { AnsiColor = "Fuchsia" } },
    { Text = text },
  })
end

return {
  -- sessions
  { key = "h", mods = "LEADER", action = act.EmitEvent("hello") },
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
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  -- Tap navigation
  { key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
  -- Word jumping
  { key = "LeftArrow", mods = "SUPER", action = act.SendString("\x1bb") },
  { key = "RightArrow", mods = "SUPER", action = act.SendString("\x1bf") },
  -- open wezterm settings in new tab
  {
    key = ",",
    mods = "SUPER",
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir, args = { "nvim", wezterm.config_file } }),
  },
  -- Tab renaming
  {
    key = "r",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = desc("Renaming tab title:"),
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }),
  },
}
