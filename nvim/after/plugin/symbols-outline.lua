local ns = "[plugin/symbols-outline]"
local found_outline, outline = pcall(require, "symbols-outline")
if not found_outline then
  return
end

local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end

local symbols = {}

for name, i in pairs(utils.get_icon("kind")) do
  symbols[name] = { icon = i, hl = utils.get_symbol_kind_hl(name).link }
end

outline.setup({
  symbols = symbols,
})
