local ns = "cange.telescope.init"
local found_telescope, telescope = pcall(require, "telescope")
if not found_telescope then
  print("[" .. ns .. '] "telescope" not found')
  return
end
local found_setup, _ = pcall(require, "cange.telescope.setup")
if not found_setup then
  print("[" .. ns .. '] "cange.telescope.setup" not found')
  return
end
local found_custom, _ = pcall(require, "cange.telescope.custom")
if not found_custom then
  print("[" .. ns .. '] "cange.telescope.custom" not found')
  return
end
-- config
telescope.load_extension("textcase")
telescope.load_extension("session-lens")
telescope.load_extension("notify")
telescope.load_extension("projects")
