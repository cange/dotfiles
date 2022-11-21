local ns = "[plugin/alpha]"
local found, alpha = pcall(require, "alpha")
if not found then
  return
end

local dashboard = require("alpha.themes.dashboard")
local section = dashboard.section

local function button(key, label, cmd)
  local opts = {}
  local btn = dashboard.button(key, label, cmd, opts)
  btn.opts.hl_shortcut = "Macro"
  return btn
end

local found_utils, utils = pcall(require, "cange.utils")
if not found_utils then
  print(ns, '"cange.utils" not found')
  return
end
local found_keymap_groups, keymap_groups = pcall(require, "cange.keymaps.groups")
if not found_keymap_groups then
  print(ns, '"cange.keymaps.groups" not found')
  return
end

---Pick up designated keys from keymap groups
local function buttons()
  local btns = {}
  for _, g in pairs(keymap_groups) do
    for key, m in pairs(g.mappings) do
      if m.dashboard == true then
        table.insert(btns, button(key, (m.icon or "") .. " " .. m.desc, m.cmd))
      end
    end
  end

  return btns
end

section.buttons.val = buttons()
section.footer.val = utils.greetings.random_with_name(utils.get_config("author.display_name"))
section.header.opts.hl = "Include"
section.buttons.opts.hl = "Macro"
section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
