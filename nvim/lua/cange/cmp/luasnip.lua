local ns = "[cange.cmp.luasnip]"
local found_luasnip, _ = pcall(require, "luasnip")
if not found_luasnip then
  print(ns, '"luasnip" not found')
  return
end

local function load_sources()
  local vscode_loader = require("luasnip.loaders.from_vscode")
  vscode_loader.lazy_load()
  vscode_loader.lazy_load({ paths = "./lua/snippets" })
end

local function choices()
  local found_choices_ui, choices_ui = pcall(require, "cange.cmp.choices-ui")
  if not found_choices_ui then
    print(ns, '"cange.cmp.choices-ui" not found')
  end
  choices_ui.setup()
end

---@module 'luasnip'

local M = {}

function M.setup()
  load_sources()
  choices()
end

return M
