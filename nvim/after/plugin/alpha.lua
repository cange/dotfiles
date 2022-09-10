local found, alpha = pcall(require, 'alpha')
if not found then return end

local dashboard = require('alpha.themes.dashboard')
local section = dashboard.section

local function button(sc, txt, keybind, keybind_opts)
  local btn = dashboard.button(sc, txt, keybind, keybind_opts)
  btn.opts.hl_shortcut = 'Macro'
  return btn
end

local found_icons, icons = pcall(require, 'cange.icons')
if not found_icons then
  vim.notify('alpha: "cange.icons" could not be found')
  return
end
local found_meta, meta = pcall(require, 'cange.settings.meta')
if not found_meta then
  vim.notify('alpha: "cange.settings.meta" could not be found')
  return
end
local found_greetings, greetings = pcall(require, 'cange.utils.greetings')
if not found_greetings then
  vim.notify('alpha: "cange.utils.greetings" could not be found')
  return
end

section.buttons.val = {
  button('f', icons.documents.Files .. '  Find file', ':Telescope find_files<CR>'),
  button('e', icons.ui.NewFile .. '  New file', ':ene <BAR> startinsert <CR>'),
  button('p', icons.git.Repo .. '  Find project', ':lua require("telescope").extensions.projects.projects()<CR>'),
  button('r', icons.ui.History .. '  Recent files', ':Telescope oldfiles <CR>'),
  button('t', icons.ui.List .. '  Find text', ':Telescope live_grep <CR>'),
  -- button('s', icons.ui.SignIn .. ' Find Session', ':silent Autosession search <CR>'),
  -- button('s', icons.ui.SignIn .. '  Find Session', ':SearchSession<CR>'),
  button('c', icons.ui.Gear .. '  Config', ':e ~/.config/nvim/init.lua <CR>'),
  button('u', icons.ui.CloudDownload .. '  Update', ':PackerSync<CR>'),
  button('q', icons.ui.SignOut .. '  Quit', ':qa<CR>'),
}

section.footer.val = greetings.random_with_name(meta.author.display_name)
section.header.opts.hl = 'Include'
section.buttons.opts.hl = 'Macro'
section.footer.opts.hl = 'Type'

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
