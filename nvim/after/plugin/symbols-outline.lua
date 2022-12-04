-- local ns = "[plugin/symbols-outline]"
local found_outline, outline = pcall(require, "symbols-outline")
if not found_outline then
  return
end

local symbols = {}

for name, i in pairs(Cange.get_icon("kind")) do
  symbols[name] = { icon = i, hl = Cange.get_symbol_kind_hl(name).link }
end

outline.setup({
  symbols = symbols,
})
