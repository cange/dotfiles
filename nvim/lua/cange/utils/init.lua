local ns = 'cange.utils.init'
local found_greetings, greetings = pcall(require, 'cange.utils.greetings')
if not found_greetings then
  print('[' .. ns .. '] "cange.utils.greetings" not found')
  return
end
local found_loaders, loaders = pcall(require, 'cange.utils.loaders')
if not found_loaders then
  print('[' .. ns .. '] "cange.utils.loaders" not found')
  return
end
local found_icons, icons = pcall(require, 'cange.utils.icons')
if not found_icons then
  print('[' .. ns .. '] "cange.utils.icons" not found')
  return
end
local found_keymaps, keymaps = pcall(require, 'cange.utils.keymaps')
if not found_keymaps then
  print('[' .. ns .. '] "cange.utils.keymaps" not found')
  return
end

return {
  bulk_loader = loaders.bulk_loader,
  greetings = greetings,
  icons = icons,
  keymap = keymaps.keymap,
  load = loaders.load,
}
