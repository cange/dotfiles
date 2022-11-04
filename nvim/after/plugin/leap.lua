local ns = "[after/plugin/leap]"
local found_leap, leap = pcall(require, "leap")
if not found_leap then
  print(ns, '"leap" not found')
  return
end

leap.add_default_mappings()
