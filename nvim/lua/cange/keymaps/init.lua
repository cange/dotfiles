local ns = "[cange.keymaps]"
local found_common, _ = pcall(require, "cange.keymaps.common")
if not found_common then
  print(ns, '"cange.keymaps.common" not found')
  return
end

local found_whichkey, whichkey = pcall(require, "cange.keymaps.whichkey")
if not found_whichkey then
  print(ns, '"cange.keymaps.whichkey" not found')
  return
end

whichkey.setup()
