local ns = 'symbols-outline'
local found_outline, outline = pcall(require, ns)
if not found_outline then
  return
end
local found_utils, utils = pcall(require, 'cange.utils')
if not found_utils then
  print('[' .. ns .. '] "cange.utils" not found')
  return
end

local symbol_icons = vim.tbl_extend('keep', utils.icons.type, utils.icons.kind)
local symbols = {}
for name, i in pairs(symbol_icons) do
  symbols[name] = { icon = i }
end

outline.setup({
  symbols = symbols,
})
