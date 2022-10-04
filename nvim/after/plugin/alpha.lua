local ns = 'alpha'
local found, alpha = pcall(require, ns)
if not found then
  return
end

local dashboard = require('alpha.themes.dashboard')
local section = dashboard.section

local function button(sc, txt, keybind, keybind_opts)
  local btn = dashboard.button(sc, txt, keybind, keybind_opts)
  btn.opts.hl_shortcut = 'Macro'
  return btn
end

local found_utils, utils = pcall(require, 'cange.utils')
if not found_utils then
  print('[' .. ns .. '] "cange.utils" not found')
  return
end
local found_meta, meta = pcall(require, 'cange.meta')
if not found_meta then
  print('[' .. ns .. '] "cange.meta" not found')
  return
end
local found_greetings, greetings = pcall(require, 'cange.utils.greetings')
if not found_greetings then
  print('[' .. ns .. '] "cange.utils.greetings" not found')
  return
end

section.buttons.val = {
  button('R', utils.icons.ui.History ..       '  Recent session', '<cmd>RestoreSession<CR>'),
  button('r', utils.icons.ui.History ..       '  Recent files',   ':Telescope oldfiles<CR>'),
  button('o', utils.icons.ui.Search ..        '  Open file',      ':Telescope find_files<CR>'),
  button('O', utils.icons.ui.Project ..       '  Open project',   ':lua require("telescope").extensions.projects.projects()<CR>'),
  button('e', utils.icons.documents.File ..   '  New file',       ':ene <BAR> startinsert <CR>'),
  button('s', utils.icons.ui.SignIn ..        '  Open session',   ':SearchSession<CR>'),
  button('t', utils.icons.ui.List ..          '  Find text',      ':Telescope live_grep <CR>'),
  button('c', utils.icons.ui.Gear ..          '  Config',         ':e ~/.config/nvim/init.lua <CR>'),
  button('u', utils.icons.ui.CloudDownload .. '  Update plugin',  ':PackerSync<CR>'),
  button('q', utils.icons.ui.SignOut ..       '  Quit',           ':qa!<CR>'),
}

section.footer.val = greetings.random_with_name(meta.author.display_name)
section.header.opts.hl = 'Include'
section.buttons.opts.hl = 'Macro'
section.footer.opts.hl = 'Type'

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
