local ns = "[symbols-outline]"
local found_outline, outline = pcall(require, "symbols-outline")
if not found_outline then
  return
end

local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end

local symbol_icons = utils.get_icon("kind")
local symbols = {}

for name, i in pairs(symbol_icons) do
  symbols[name] = { icon = i }
end

outline.setup({
  symbols = symbols,
})
