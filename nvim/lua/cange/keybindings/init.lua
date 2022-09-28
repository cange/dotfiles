local ns = 'cange.keybindings.init'
local found_common, _ = pcall(require, 'cange.keybindings.common')
if not found_common then
  print('[' .. ns .. '] "cange.keybindings.common" not found')
  return
end

local found_whichkey, whichkey = pcall(require, 'cange.keybindings.whichkey')
if not found_whichkey then
  print('[' .. ns .. '] "cange.keybindings.whichkey" not found')
  return
end

whichkey.setup()
