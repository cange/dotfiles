local ns = "cange.luasnip"
local found_luasnip, luasnip = pcall(require, "luasnip")
if not found_luasnip then
  print("[" .. ns .. '] "luasnip" not found')
  return
end

local function mappings()
  local found_utils, utils = pcall(require, "cange.utils")
  if not found_utils then
    print("[" .. ns .. '] "cange.utils" not found')
  end
  local keymap = utils.keymap

  -- -Expansion key
  -- -this will expand the current item or jump to the next item within the snippet.
  -- Mappings
  keymap({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end)

  ---Jump backwards key.
  ---this always moves to the previous item within the snippet
  keymap({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end)

  ---Selecting within a list of options.
  ---This is useful for choice nodes (introduced in the forthcoming episode 2)
  ---Go forwards within choice options
  keymap("i", "<C-]>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end)
  ---Go backwards within coice options
  keymap("i", "<C-[>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(-1)
    end
  end)

  keymap("i", "<C-u>", require("luasnip.extras.select_choice"))

  -- shorcut to source my luasnips file again, which will reload my snippets
  keymap("n", "<leader><leader>s", ":luafile ~/.config/nvim/lua/cange/luasnip/init.lua<CR>")
end

local function load_sources()
  local vscode_loader = require("luasnip.loaders.from_vscode")
  vscode_loader.lazy_load()
  vscode_loader.lazy_load({ paths = "./lua/snippets" })
end

local function choices()
  local found_choices_ui, choices_ui = pcall(require, "cange.luasnip.choices-ui")
  if not found_choices_ui then
    print("[" .. ns .. '] "cange.luasnip.choices-ui" not found')
  end
  choices_ui.setup()
end

---@module 'luasnip'

local M = {}

function M.setup()
  -- choices()
  load_sources()
  -- mappings()
end

return M
