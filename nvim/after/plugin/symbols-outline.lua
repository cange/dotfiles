local found_outline, outline = pcall(require, 'symbols-outline')
if not found_outline then
  return
end

local symbol_icons = vim.tbl_extend('keep', Cange.icons.type, Cange.icons.kind)
local symbols = {}
for name, i in pairs(symbol_icons) do
  symbols[name] = { icon = i }
end

outline.setup({
  symbols = symbols,
})
